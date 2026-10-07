create extension if not exists pgcrypto;

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  first_name text not null default '',
  last_name text not null default '',
  city text not null default 'Abomey-Calavi',
  lat double precision not null default 6.4485,
  lng double precision not null default 2.3557,
  active_role text check (active_role in ('worker','poster')),
  kyc_status text not null default 'none' check (kyc_status in ('none','pending','verified','rejected')),
  worker_profile jsonb not null default '{}'::jsonb,
  poster_profile jsonb,
  payout_account jsonb not null default '{"operator":"MTN MoMo","maskedNumber":"•• •• •• ••","holderName":""}'::jsonb,
  created_at timestamptz not null default now()
);

create table public.profiles_private (
  id uuid primary key references public.profiles(id) on delete cascade,
  birth_date date,
  consents jsonb not null default '{}'::jsonb
);

create table public.kyc_submissions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  doc_type text not null check (doc_type in ('id_card','passport')),
  country_code text not null,
  paths jsonb not null,
  status text not null default 'pending' check (status in ('pending','verified','rejected')),
  reason text,
  submitted_at timestamptz not null default now()
);

create table public.wallets (
  poster_id uuid primary key references public.profiles(id) on delete cascade,
  balance integer not null check (balance >= 0)
);

create table public.cities (name text primary key, lat double precision not null, lng double precision not null);

create table public.missions (
  id text primary key default gen_random_uuid()::text,
  poster_id uuid not null references public.profiles(id),
  title text not null,
  category text not null,
  description text not null default '',
  city text not null,
  zone_lat double precision not null,
  zone_lng double precision not null,
  start_at timestamptz not null,
  duration_min integer not null,
  pay_amount integer not null,
  pay_unit text not null default 'flat' check (pay_unit in ('flat','hourly','daily')),
  slot_amount integer not null,
  slots_total integer not null check (slots_total between 1 and 50),
  slots_free integer not null,
  apply_deadline timestamptz not null,
  published_at timestamptz not null default now(),
  status text not null default 'published' check (status in ('published','filled','expired','cancelled')),
  public_questions_count integer not null default 0
);

create table public.mission_locations (
  mission_id text primary key references public.missions(id) on delete cascade,
  district text not null default '',
  address text not null default '',
  landmark text not null default '',
  lat double precision not null,
  lng double precision not null,
  briefing text not null default ''
);

create table public.applications (
  id text primary key default gen_random_uuid()::text,
  mission_id text not null references public.missions(id) on delete cascade,
  worker_id uuid not null references public.profiles(id),
  status text not null check (status in ('pending','pending_sync','offered','confirmed','declined','withdrawn','rejected','expired','cancelled')),
  message text not null default '',
  created_at timestamptz not null default now(),
  offer_expires_at timestamptz,
  assignment_id text,
  unique (mission_id, worker_id)
);

create table public.assignments (
  id text primary key default gen_random_uuid()::text,
  mission_id text not null references public.missions(id) on delete cascade,
  application_id text not null references public.applications(id),
  worker_id uuid not null references public.profiles(id),
  status text not null check (status in ('confirmed','in_progress','submitted','contested','paid','cancelled')),
  pay_amount integer not null,
  payout_operator text not null default 'MTN MoMo',
  check_in_at timestamptz,
  check_in_distance_m integer,
  check_out_at timestamptz,
  note text,
  photos jsonb not null default '[]'::jsonb,
  auto_validate_at timestamptz,
  contest_reason text,
  cancelled_by text check (cancelled_by in ('worker','poster')),
  payout_id text
);

create table public.blocked_funds (
  mission_id text primary key references public.missions(id) on delete cascade,
  poster_id uuid not null references public.profiles(id),
  amount integer not null check (amount > 0)
);

create table public.payouts (
  id text primary key,
  worker_id uuid not null references public.profiles(id),
  poster_id uuid references public.profiles(id),
  assignment_id text,
  amount integer not null,
  gross_amount integer not null,
  mission_title text not null,
  poster_name text not null,
  validated_at timestamptz not null,
  commission_label text not null default 'Aucune (démo)',
  account_label text not null,
  reference text not null,
  status text not null default 'paid'
);
create sequence public.payout_seq start 4900;

create table public.poster_reviews (
  id uuid primary key default gen_random_uuid(),
  poster_id uuid not null references public.profiles(id) on delete cascade,
  author_name text not null, stars integer not null, comment text not null,
  context text not null, date timestamptz not null, reply text
);

create table public.alerts (
  id text primary key default gen_random_uuid()::text,
  owner_id uuid not null references public.profiles(id) on delete cascade,
  keyword text, category text, zone text not null, min_pay integer, days text not null,
  created_at timestamptz not null default now()
);

-- RLS : tout est fermé ; les lectures et écritures passent par les fonctions
-- security definer. Les lectures directes autorisées sont listées ici.
alter table public.profiles enable row level security;
alter table public.profiles_private enable row level security;
alter table public.kyc_submissions enable row level security;
alter table public.wallets enable row level security;
alter table public.cities enable row level security;
alter table public.missions enable row level security;
alter table public.mission_locations enable row level security;
alter table public.applications enable row level security;
alter table public.assignments enable row level security;
alter table public.blocked_funds enable row level security;
alter table public.payouts enable row level security;
alter table public.poster_reviews enable row level security;
alter table public.alerts enable row level security;

create policy "profil : lecture de soi" on public.profiles for select to authenticated using (id = auth.uid());
create policy "villes : lecture" on public.cities for select to authenticated using (true);
create policy "alertes : les siennes" on public.alerts for select to authenticated using (owner_id = auth.uid());
-- Aucune policy insert/update/delete pour authenticated : toute écriture passe par RPC.

-- Storage : buckets privés.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('kyc', 'kyc', false, 5242880, array['image/jpeg','image/png']),
       ('proofs', 'proofs', false, 5242880, array['image/jpeg','image/png'])
on conflict (id) do nothing;

create policy "kyc : dépôt dans son dossier" on storage.objects for insert to authenticated
  with check (bucket_id = 'kyc' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "preuves : dépôt par l’exécutant" on storage.objects for insert to authenticated
  with check (bucket_id = 'proofs' and exists (
    select 1 from public.assignments a
    where a.id = (storage.foldername(name))[1] and a.worker_id = auth.uid() and a.status = 'in_progress'));
create policy "preuves : lecture par les parties" on storage.objects for select to authenticated
  using (bucket_id = 'proofs' and exists (
    select 1 from public.assignments a join public.missions m on m.id = a.mission_id
    where a.id = (storage.foldername(name))[1] and (a.worker_id = auth.uid() or m.poster_id = auth.uid())));
