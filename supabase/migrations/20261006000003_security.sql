-- Sécurité : droits d’exécution explicites, policies des preuves via des fonctions
-- security definer, validation complète de la pièce d’identité.

-- 1. Les nouvelles fonctions ne sont plus exécutables par défaut : chaque migration
--    accorde explicitement ce qui doit l’être.
alter default privileges for role postgres in schema public
  revoke execute on functions from public, anon, authenticated;
-- PUBLIC reçoit EXECUTE par un défaut global (non révocable schéma par schéma).
alter default privileges for role postgres
  revoke execute on functions from public;

-- 2. Policies du bucket « proofs ». Les sous-requêtes des policies s’exécutent sous RLS
--    en tant que « authenticated » et ne voient ni missions ni affectations : on passe
--    par des fonctions security definer.
create or replace function public.can_upload_proof(aid text) returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.assignments a
    where a.id = aid and a.worker_id = auth.uid() and a.status = 'in_progress')
$$;

create or replace function public.can_read_proof(aid text) returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.assignments a join public.missions m on m.id = a.mission_id
    where a.id = aid and (a.worker_id = auth.uid() or m.poster_id = auth.uid()))
$$;

drop policy if exists "preuves : dépôt par l’exécutant" on storage.objects;
drop policy if exists "preuves : lecture par les parties" on storage.objects;

create policy "preuves : dépôt par l’exécutant" on storage.objects for insert to authenticated
  with check (bucket_id = 'proofs' and public.can_upload_proof((storage.foldername(name))[1]));
create policy "preuves : lecture par les parties" on storage.objects for select to authenticated
  using (bucket_id = 'proofs' and public.can_read_proof((storage.foldername(name))[1]));

-- 3. Pièce d’identité : type et pays obligatoires.
create or replace function public.submit_kyc(document_type text, country_code text,
  front_path text, back_path text, selfie_path text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  folder text := public.uid()::text || '/';
  submitted timestamptz;
begin
  if document_type is null or document_type not in ('id_card', 'passport') then
    perform public.err('422', 'Type de pièce inconnu.');
  end if;
  if trim(coalesce(country_code, '')) = '' then
    perform public.err('422', 'Indiquez le pays de la pièce.');
  end if;
  -- Recto et selfie toujours ; verso sauf passeport. Les photos doivent être
  -- dans le dossier de l’utilisateur (bucket kyc).
  if coalesce(front_path, '') = '' or coalesce(selfie_path, '') = ''
     or (document_type <> 'passport' and coalesce(back_path, '') = '')
     or not starts_with(front_path, folder) or not starts_with(selfie_path, folder)
     or (coalesce(back_path, '') <> '' and not starts_with(back_path, folder)) then
    perform public.err('422', 'Photographiez le recto et le verso.');
  end if;
  insert into public.kyc_submissions (user_id, doc_type, country_code, paths)
    values (me, document_type, trim(country_code), jsonb_build_object(
      'front', front_path, 'back', nullif(back_path, ''), 'selfie', selfie_path))
    returning submitted_at into submitted;
  update public.profiles set kyc_status = 'pending' where id = me;
  return jsonb_build_object('status', 'pending', 'submittedAt', public.iso(submitted));
end $$;

-- 4. Droits d’exécution : seules les RPC sont appelables par les clients. Les aides
--    internes (err, uid, iso, account_json, alert_json, handle_new_user) ne sont
--    appelées que depuis des fonctions security definer, qui s’exécutent en tant que
--    propriétaire : aucun droit n’est nécessaire.
revoke all on all functions in schema public from public, anon, authenticated;
grant execute on function public.me(), public.set_role(text), public.save_profile(text,text,text,boolean,boolean),
  public.submit_kyc(text,text,text,text,text), public.get_kyc(),
  public.list_alerts(), public.create_alert(text,text,text,integer,text), public.delete_alert(text),
  public.can_upload_proof(text), public.can_read_proof(text)
  to authenticated;
