-- Aides partagées des tests pgTAP, incluses par chaque fichier via \ir.
-- Tout est créé dans la transaction du test, donc annulé par le rollback final.
-- Exécuté seul (supabase test db lance tous les .sql du dossier), le fichier ne
-- crée rien et se déclare « sauté » pour pg_prove.
\if :{?with_helpers}
create schema if not exists tests;

-- Crée un utilisateur de test (le trigger d’inscription crée son profil).
create or replace function tests.make_user(email text) returns uuid language plpgsql as $$
declare id uuid := gen_random_uuid();
begin
  insert into auth.users (id, email, aud, role, instance_id)
  values (id, email, 'authenticated', 'authenticated', '00000000-0000-0000-0000-000000000000');
  return id;
end $$;

-- Ouvre une session « authenticated » au nom de l’utilisateur.
create or replace function tests.login_as(id uuid) returns void language plpgsql as $$
begin
  perform set_config('role', 'authenticated', true);
  perform set_config('request.jwt.claims', json_build_object('sub', id, 'role', 'authenticated')::text, true);
end $$;

-- Session expirée : le rôle reste « authenticated » mais le jeton n’a plus d’utilisateur.
create or replace function tests.logout() returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', '', true);
end $$;

-- Visiteur non connecté : rôle « anon », sans jeton.
create or replace function tests.as_anon() returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claims', '', true);
  perform set_config('role', 'anon', true);
end $$;

-- Identifiants (dans l’ordre de la liste) des éléments de [items] qui font partie de [mine] :
-- permet d’asserter sur les seules lignes du test, quelles que soient les autres données.
create or replace function tests.ids_of(items jsonb, mine text[]) returns text[] language sql stable as $$
  select coalesce(array_agg(i->>'id' order by n), '{}')
  from jsonb_array_elements(items) with ordinality t(i, n) where i->>'id' = any(mine)
$$;

-- Nombre de missions d’une ville dans list_cities() (0 si la ville est absente).
create or replace function tests.city_count(cities jsonb, city text) returns int language sql stable as $$
  select coalesce(max((i->>'count')::int), 0) from jsonb_array_elements(cities->'items') i where i->>'city' = city
$$;

grant usage on schema tests to anon, authenticated;
grant execute on all functions in schema tests to anon, authenticated;
\else
\echo 1..0 # SKIP fichier d’aides, inclus par les autres tests
\endif
