-- Identité : session, profil, rôle, KYC et alertes.
-- Les messages et le JSON reprennent ceux du faux serveur.

create or replace function public.err(code text, msg text) returns void
language plpgsql as $$ begin raise exception using errcode = 'MO' || code, message = msg; end $$;

create or replace function public.uid() returns uuid
language plpgsql stable as $$
begin
  if auth.uid() is null then perform public.err('401', 'Votre session a expiré. Reconnectez-vous.'); end if;
  return auth.uid();
end $$;

-- Un profil vide est créé à chaque inscription.
create or replace function public.handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, email) values (new.id, lower(new.email)) on conflict do nothing;
  insert into public.profiles_private (id) values (new.id) on conflict do nothing;
  return new;
end $$;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

create or replace function public.account_json(p public.profiles) returns jsonb
language sql stable as $$
  select jsonb_build_object('id', p.id, 'email', p.email, 'firstName', p.first_name,
    'city', p.city, 'role', p.active_role)
$$;

create or replace function public.me() returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare p public.profiles;
begin
  select * into p from public.profiles where id = public.uid();
  return public.account_json(p);
end $$;

-- Date au format ISO 8601 UTC, comme toIso8601String() côté client.
create or replace function public.iso(ts timestamptz) returns text
language sql immutable as $$
  select to_char(ts at time zone 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')
$$;

create or replace function public.set_role(role text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  p public.profiles;
begin
  if set_role.role is null or set_role.role not in ('worker', 'poster') then
    perform public.err('422', 'Rôle inconnu.');
  end if;
  update public.profiles set active_role = set_role.role where id = me returning * into p;
  if set_role.role = 'poster' then
    insert into public.wallets (poster_id, balance) values (me, 200000) on conflict do nothing;
    update public.profiles set poster_profile = jsonb_build_object(
        'id', p.id,
        'displayName', trim(p.first_name || ' ' ||
          case when p.last_name = '' then '' else left(p.last_name, 1) || '.' end),
        'initials', case when p.first_name = '' then '?' else upper(left(p.first_name, 1)) end,
        'verified', false,
        'reliable', false,
        'city', p.city,
        'memberSince', public.iso(now()),
        'rating', 0.0,
        'reviewsCount', 0,
        'paidMissions', 0,
        'avgValidationHours', 0)
      where id = me and poster_profile is null;
  end if;
  return public.account_json(p);
end $$;

create or replace function public.save_profile(first_name text, last_name text, birth_date text,
  accept_terms boolean, accept_newsletter boolean) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  fname text := trim(coalesce(save_profile.first_name, ''));
  lname text := trim(coalesce(save_profile.last_name, ''));
  born date;
  today date := (now() at time zone 'UTC')::date;
begin
  if fname = '' or lname = '' then
    perform public.err('422', 'Prénom et nom sont obligatoires.');
  end if;
  if accept_terms is distinct from true then
    perform public.err('422', 'Vous devez accepter les conditions générales.');
  end if;
  begin
    if save_profile.birth_date !~ '^\d{4}-\d{2}-\d{2}' then raise exception 'format'; end if;
    born := left(save_profile.birth_date, 10)::date;
  exception when others then
    born := null;
  end;
  if born is null then
    perform public.err('422', 'Date de naissance invalide.');
  end if;
  if extract(year from age(today, born)) < 18 then
    perform public.err('422', 'Vous devez avoir au moins 18 ans.');
  end if;
  update public.profiles
    set first_name = fname, last_name = upper(left(lname, 1)) || '.'
    where id = me;
  insert into public.profiles_private (id, birth_date, consents)
    values (me, born, jsonb_build_object('terms', true, 'newsletter', accept_newsletter is true))
    on conflict (id) do update set birth_date = excluded.birth_date, consents = excluded.consents;
  return jsonb_build_object('firstName', fname, 'lastName', lname, 'birthDate', save_profile.birth_date);
end $$;

create or replace function public.submit_kyc(document_type text, country_code text,
  front_path text, back_path text, selfie_path text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  folder text := public.uid()::text || '/';
  submitted timestamptz;
begin
  -- Recto et selfie toujours ; verso sauf passeport. Les photos doivent être
  -- dans le dossier de l’utilisateur (bucket kyc).
  if coalesce(front_path, '') = '' or coalesce(selfie_path, '') = ''
     or (document_type is distinct from 'passport' and coalesce(back_path, '') = '')
     or not starts_with(front_path, folder) or not starts_with(selfie_path, folder)
     or (coalesce(back_path, '') <> '' and not starts_with(back_path, folder)) then
    perform public.err('422', 'Photographiez le recto et le verso.');
  end if;
  insert into public.kyc_submissions (user_id, doc_type, country_code, paths)
    values (me, document_type, country_code, jsonb_build_object(
      'front', front_path, 'back', nullif(back_path, ''), 'selfie', selfie_path))
    returning submitted_at into submitted;
  update public.profiles set kyc_status = 'pending' where id = me;
  return jsonb_build_object('status', 'pending', 'submittedAt', public.iso(submitted));
end $$;

create or replace function public.get_kyc() returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare
  me uuid := public.uid();
  status text;
  submitted timestamptz;
begin
  select kyc_status into status from public.profiles where id = me;
  select submitted_at into submitted from public.kyc_submissions
    where user_id = me order by submitted_at desc limit 1;
  return jsonb_build_object('status', coalesce(status, 'none'), 'submittedAt', public.iso(submitted));
end $$;

create or replace function public.alert_json(a public.alerts) returns jsonb
language sql stable as $$
  select jsonb_build_object('id', a.id, 'ownerId', a.owner_id, 'keyword', a.keyword,
    'category', a.category, 'zone', a.zone, 'minPay', a.min_pay, 'days', a.days)
$$;

create or replace function public.list_alerts() returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  return coalesce((select jsonb_agg(public.alert_json(a) order by a.created_at, a.id)
    from public.alerts a where a.owner_id = me), '[]'::jsonb);
end $$;

create or replace function public.create_alert(keyword text, category text, zone text,
  min_pay integer, days text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  z text := trim(coalesce(create_alert.zone, ''));
  d text := trim(coalesce(create_alert.days, ''));
  a public.alerts;
begin
  if z = '' or d = '' then
    perform public.err('422', 'Choisissez une zone et des jours.');
  end if;
  insert into public.alerts (owner_id, keyword, category, zone, min_pay, days, created_at)
    values (me, create_alert.keyword, create_alert.category, z, create_alert.min_pay, d, clock_timestamp())
    returning * into a;
  return public.alert_json(a);
end $$;

create or replace function public.delete_alert(id text) returns void
language plpgsql security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  delete from public.alerts a where a.id = delete_alert.id and a.owner_id = me;
  if not found then
    perform public.err('404', 'Alerte introuvable.');
  end if;
end $$;

revoke all on all functions in schema public from public, anon;
grant execute on function public.me(), public.set_role(text), public.save_profile(text,text,text,boolean,boolean),
  public.submit_kyc(text,text,text,text,text), public.get_kyc(),
  public.list_alerts(), public.create_alert(text,text,text,integer,text), public.delete_alert(text)
  to authenticated;
