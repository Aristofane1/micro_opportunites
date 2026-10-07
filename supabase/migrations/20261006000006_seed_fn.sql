-- Données de démonstration : reprise fidèle de test/support/fake_backend/seed.dart
-- (mêmes identifiants, textes, montants et horaires relatifs à now()).
--
-- seed_demo(accounts, reset) est appelée par supabase/seed/seed.mjs avec la clé
-- service_role, une fois les comptes créés par l’API admin. accounts associe les
-- utilisateurs du faux serveur aux comptes réels :
--   {"executant": u1, "executant2": u2, "ganiou": u3, "annonceur": u10,
--    "p1": …, "p2": …, "p3": …}
--
-- reset = true  : supprime d’abord les données de démo (tout ce qui appartient aux
--                 7 comptes, et les identifiants de démo m1…, a1…, po1…, al1…), puis
--                 réécrit l’état initial. Les données des autres utilisateurs ne sont
--                 jamais supprimées.
-- reset = false : n’écrit que ce qui manque (une mission déjà présente garde son état,
--                 ses candidatures, affectations et montants bloqués ne sont pas réécrits).
--
-- Retourne le nombre de lignes écrites : missions, candidatures, affectations, versements.

create or replace function public.seed_demo(accounts jsonb, reset boolean default false) returns jsonb
language plpgsql security definer set search_path = public set "TimeZone" = 'UTC' as $$
declare
  keys constant text[] := array['executant', 'executant2', 'ganiou', 'annonceur', 'p1', 'p2', 'p3'];
  demo_missions constant text[] := array['m1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'm9', 'm10',
    'm11', 'm12', 'm13', 'm14', 'm15', 'm20', 'm21'];
  demo_applications constant text[] := array['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a20', 'a21', 'a22'];
  demo_assignments constant text[] := array['as1', 'm21'];
  demo_payouts constant text[] := array['po1', 'po2', 'po3', 'po4', 'po5', 'po6'];
  demo_alerts constant text[] := array['al1', 'al2', 'al3'];
  k text;
  ids uuid[];
  u1 uuid; u2 uuid; u3 uuid; u10 uuid; p1 uuid; p2 uuid; p3 uuid;
  -- Minuit (heure du Bénin, UTC+1) du jour courant, en UTC : t.at(d, h, m) = day0 + d jours + h:m.
  day0 timestamptz := (public.benin_day(now())::timestamp - interval '1 hour') at time zone 'UTC';
  reset_missions text[];
  new_missions text[];
  n_missions integer;
  n_applications integer;
  n_assignments integer;
  n_payouts integer;
  wp_u1 jsonb;
  wp_u2 jsonb;
  wp_u3 jsonb;
begin
  -- 1. Comptes : les 7 clés, des uuid distincts, des profils existants.
  if jsonb_typeof(accounts) is distinct from 'object' then
    raise exception 'seed_demo : accounts doit être un objet JSON.';
  end if;
  foreach k in array keys loop
    if jsonb_typeof(accounts->k) is distinct from 'string' then
      raise exception 'seed_demo : compte « % » manquant.', k;
    end if;
    begin
      ids := ids || (accounts->>k)::uuid;
    exception when invalid_text_representation then
      raise exception 'seed_demo : compte « % » invalide.', k;
    end;
    if not exists (select 1 from public.profiles p where p.id = (accounts->>k)::uuid) then
      raise exception 'seed_demo : profil du compte « % » introuvable.', k;
    end if;
  end loop;
  if (select count(distinct x) from unnest(ids) x) <> cardinality(keys) then
    raise exception 'seed_demo : les comptes doivent être distincts.';
  end if;
  u1 := ids[1]; u2 := ids[2]; u3 := ids[3]; u10 := ids[4]; p1 := ids[5]; p2 := ids[6]; p3 := ids[7];

  -- 2. Remise à zéro : uniquement les données de démo.
  if reset then
    -- Missions concernées : les identifiants de démo et celles publiées par les comptes de démo.
    select coalesce(array_agg(m.id), '{}') into reset_missions
      from public.missions m where m.id = any(demo_missions) or m.poster_id = any(ids);

    -- Affectations actives d’un compte de démo sur la mission d’un autre utilisateur :
    -- la place est rendue avant suppression.
    update public.missions m set slots_free = least(m.slots_free + s.n, m.slots_total)
      from (select y.mission_id, count(*)::int as n from public.assignments y
            where y.worker_id = any(ids)
              and y.status in ('confirmed', 'in_progress', 'submitted', 'contested')
              and not (y.mission_id = any(reset_missions))
            group by y.mission_id) s
      where m.id = s.mission_id;

    delete from public.assignments y
      where y.worker_id = any(ids) or y.id = any(demo_assignments)
         or y.mission_id = any(reset_missions);
    delete from public.applications x
      where x.worker_id = any(ids) or x.id = any(demo_applications)
         or x.mission_id = any(reset_missions);
    delete from public.blocked_funds b
      where b.poster_id = any(ids) or b.mission_id = any(reset_missions);
    delete from public.missions m where m.id = any(reset_missions);
    delete from public.payouts p where p.worker_id = any(ids) or p.id = any(demo_payouts);
    delete from public.alerts a where a.owner_id = any(ids) or a.id = any(demo_alerts);
    delete from public.poster_reviews r where r.poster_id = any(ids);
    delete from public.wallets w where w.poster_id = any(ids);
    delete from public.kyc_submissions s where s.user_id = any(ids);
  end if;

  -- 3. Profils (réécrits au reset, sinon seulement s’ils n’ont jamais été remplis).
  wp_u1 := jsonb_build_object(
    'rating', 4.7,
    'reviewsCount', 11,
    'missionsCount', 14,
    'reliability', 96,
    'absences', 0,
    'skills', jsonb_build_array('Flyers', 'Informatique'),
    'pitch', 'Ponctuel, à l’aise avec le public.',
    'memberSince', public.iso(now() - interval '300 days'),
    'verified', true,
    'doneMissions', jsonb_build_array(
      jsonb_build_object('category', 'flyers', 'count', 6),
      jsonb_build_object('category', 'computer', 'count', 4)),
    'lastReview', jsonb_build_object(
      'author', 'Boutique Lumière',
      'stars', 5,
      'text', 'Ponctuel et efficace, flyers tous distribués.',
      'punctuality', 5,
      'quality', 5,
      'communication', 4));
  wp_u2 := jsonb_build_object(
    'rating', 4.9,
    'reviewsCount', 22,
    'missionsCount', 31,
    'reliability', 98,
    'absences', 0,
    'skills', jsonb_build_array('Saisie', 'Événements'),
    'pitch', 'Expérience en saisie et accueil.',
    'memberSince', public.iso(now() - interval '420 days'),
    'verified', true,
    'doneMissions', jsonb_build_array(
      jsonb_build_object('category', 'data_entry', 'count', 12),
      jsonb_build_object('category', 'event', 'count', 9)),
    'lastReview', jsonb_build_object(
      'author', 'Cabinet Hounkpè',
      'stars', 5,
      'text', 'Saisie rapide et sans erreur, très à l’aise à l’accueil.',
      'punctuality', 5,
      'quality', 5,
      'communication', 5));
  wp_u3 := jsonb_build_object(
    'rating', null,
    'reviewsCount', 0,
    'missionsCount', 0,
    'reliability', null,
    'absences', 0,
    'skills', '[]'::jsonb,
    'pitch', 'Disponible tout de suite.',
    'memberSince', public.iso(now() - interval '6 days'),
    'verified', true);

  update public.profiles p set
      first_name = v.first_name, last_name = v.last_name, city = v.city, lat = v.lat, lng = v.lng,
      active_role = v.role, kyc_status = 'verified', worker_profile = v.wp, poster_profile = v.pp,
      payout_account = coalesce(v.payout, p.payout_account)
    from (values
      (u1, 'Rodrigue', 'K.', 'Abomey-Calavi', 6.4485, 2.3557, 'worker', wp_u1, null::jsonb,
        jsonb_build_object('operator', 'MTN MoMo', 'maskedNumber', '01 97 •• •• 45', 'holderName', 'Rodrigue K.')),
      (u2, 'Sènami', 'O.', 'Abomey-Calavi', 6.4500, 2.3500, 'worker', wp_u2, null::jsonb,
        jsonb_build_object('operator', 'Moov Money', 'maskedNumber', '01 66 •• •• 12', 'holderName', 'Sènami O.')),
      (u3, 'Ganiou', 'A.', 'Godomey', 6.4200, 2.3400, 'worker', wp_u3, null::jsonb,
        jsonb_build_object('operator', 'MTN MoMo', 'maskedNumber', '01 51 •• •• 08', 'holderName', 'Ganiou A.')),
      (u10, 'Mireille', 'A.', 'Abomey-Calavi', 6.4520, 2.3480, 'poster', '{}'::jsonb,
        jsonb_build_object(
          'id', u10, 'displayName', 'Mireille A.', 'initials', 'MA', 'verified', true, 'reliable', true,
          'city', 'Abomey-Calavi', 'memberSince', public.iso(now() - interval '120 days'),
          'rating', 4.7, 'reviewsCount', 6, 'paidMissions', 4, 'avgValidationHours', 5),
        jsonb_build_object('operator', 'MTN MoMo', 'maskedNumber', '01 90 •• •• 77', 'holderName', 'Mireille A.')),
      (p1, 'Adjovi', 'H.', 'Abomey-Calavi', 6.4600, 2.3400, 'poster', '{}'::jsonb,
        jsonb_build_object(
          'id', p1, 'displayName', 'Adjovi H.', 'initials', 'AH', 'verified', true, 'reliable', true,
          'city', 'Abomey-Calavi', 'memberSince', public.iso(now() - interval '200 days'),
          'rating', 4.8, 'reviewsCount', 23, 'paidMissions', 12, 'avgValidationHours', 3),
        null::jsonb),
      (p2, 'Koffi', 'D.', 'Abomey-Calavi', 6.4600, 2.3400, 'poster', '{}'::jsonb,
        jsonb_build_object(
          'id', p2, 'displayName', 'Koffi D.', 'initials', 'KD', 'verified', true, 'reliable', false,
          'city', 'Abomey-Calavi', 'memberSince', public.iso(now() - interval '90 days'),
          'rating', 4.6, 'reviewsCount', 9, 'paidMissions', 5, 'avgValidationHours', 6),
        null::jsonb),
      (p3, 'Chantal', 'A.', 'Cotonou', 6.3703, 2.3912, 'poster', '{}'::jsonb,
        jsonb_build_object(
          'id', p3, 'displayName', 'Chantal A.', 'initials', 'CA', 'verified', true, 'reliable', true,
          'city', 'Cotonou', 'memberSince', public.iso(now() - interval '400 days'),
          'rating', 4.9, 'reviewsCount', 15, 'paidMissions', 8, 'avgValidationHours', 2),
        null::jsonb)
    ) as v(id, first_name, last_name, city, lat, lng, role, wp, pp, payout)
    where p.id = v.id and (reset or p.first_name = '');

  -- 4. Portefeuille de l’annonceur de démo.
  insert into public.wallets (poster_id, balance) values (u10, 200000) on conflict (poster_id) do nothing;

  -- 5. Avis sur les annonceurs (si l’annonceur n’en a pas encore).
  insert into public.poster_reviews (poster_id, author_name, stars, comment, context, date, reply)
    select v.poster_id, v.author_name, v.stars, v.comment, v.context, v.date, v.reply
    from (values
      (p1, 'Mireille A.', 5, 'Consignes claires, accueil sympa, payée le jour même.',
        'Aide lors d’un événement', now() - interval '20 days', null::text),
      (p1, 'Serge T.', 4, 'Lieu un peu difficile à trouver, mais le repère aidait.',
        'Distribution de flyers', now() - interval '45 days', 'Merci, j’ai ajouté une photo de l’entrée.'),
      (p2, 'Aïcha B.', 5, 'Très clair sur ce qu’il fallait faire.',
        'Installation informatique', now() - interval '30 days', null::text),
      (p3, 'Luc H.', 5, 'Paiement rapide, mission bien décrite.',
        'Saisie de données', now() - interval '12 days', null::text)
    ) as v(poster_id, author_name, stars, comment, context, date, reply)
    where not exists (select 1 from public.poster_reviews r where r.poster_id = v.poster_id);

  -- 6. Missions (slot_amount = pay, rémunération forfaitaire).
  with ins as (
    insert into public.missions (id, poster_id, title, category, description, city, zone_lat, zone_lng,
        start_at, duration_min, pay_amount, pay_unit, slot_amount, slots_total, slots_free, apply_deadline,
        published_at, status, public_questions_count)
      select v.id, v.poster_id, v.title, v.category, v.description, v.city, v.lat, v.lng,
          v.start_at, v.duration, v.pay, 'flat', v.pay, v.slots_total, v.slots_free, v.deadline,
          v.published_at, v.status, v.questions
      from (values
        ('m1', p1, 'Distribution de flyers au carrefour', 'event', 'Abomey-Calavi', 6.4550, 2.3450,
          day0 + interval '4 days 8 hours', 240, 5000, 5, 3, now() - interval '20 minutes',
          day0 + interval '3 days 18 hours',
          'Distribuer 500 flyers pour l’ouverture d’une boutique. Flyers et t-shirt fournis.', 'published', 2),
        ('m2', p2, 'Réinstaller Windows sur un portable', 'computer', 'Abomey-Calavi', 6.4400, 2.3600,
          day0 + interval '1 day 10 hours', 120, 7500, 1, 1, now() - interval '1 hour',
          day0 + interval '21 hours',
          'Réinstaller Windows 11 et les logiciels de base sur un portable HP. Clé USB fournie.', 'published', 0),
        ('m3', p3, 'Courses au marché', 'shopping', 'Cotonou', 6.3703, 2.3912,
          day0 + interval '2 days 9 hours', 90, 3000, 1, 1, now() - interval '20 hours',
          day0 + interval '1 day 20 hours',
          'Faire les courses de la semaine au marché, liste fournie.', 'published', 0),
        ('m4', p2, 'Nettoyage de bureau', 'cleaning', 'Cotonou', 6.3650, 2.4180,
          day0 + interval '6 days 8 hours', 180, 7500, 2, 2, now() - interval '3 days',
          day0 + interval '5 days 18 hours',
          'Nettoyer un bureau de 60 m² après travaux. Produits fournis.', 'published', 0),
        ('m5', p1, 'Aide au service lors d’un mariage', 'event', 'Abomey-Calavi', 6.4600, 2.3500,
          day0 + interval '11 days 11 hours', 360, 10000, 4, 4, now() - interval '2 days',
          day0 + interval '9 days 18 hours',
          'Servir les boissons et le repas pour 150 invités. Tenue fournie.', 'published', 0),
        ('m6', p3, 'Saisie de fiches clients', 'data_entry', 'Abomey-Calavi', 6.4450, 2.3700,
          day0 + interval '3 days 9 hours', 240, 6000, 2, 1, now() - interval '5 hours',
          day0 + interval '2 days 18 hours',
          'Saisir 200 fiches clients dans un tableur. Ordinateur fourni.', 'published', 0),
        ('m7', p2, 'Livraison de colis au campus', 'delivery', 'Abomey-Calavi', 6.4200, 2.3400,
          day0 + interval '15 hours', 120, 2500, 3, 2, now() - interval '2 hours',
          day0 + interval '13 hours',
          'Livrer 12 colis aux résidences universitaires. Moto non nécessaire.', 'published', 0),
        ('m8', p3, 'Réparation d’une chaise', 'repair', 'Abomey-Calavi', 6.4520, 2.3650,
          day0 + interval '2 days 16 hours', 60, 2000, 1, 1, now() - interval '1 day',
          day0 + interval '1 day 18 hours',
          'Recoller et renforcer une chaise en bois.', 'published', 0),
        ('m9', p1, 'Distribution de flyers au marché Dantokpa', 'flyers', 'Cotonou', 6.3730, 2.4290,
          day0 + interval '4 days 8 hours', 240, 4000, 4, 3, now() - interval '4 hours',
          day0 + interval '3 days 18 hours',
          'Distribuer des flyers d’une nouvelle pharmacie aux entrées du marché.', 'published', 0),
        ('m10', p3, 'Inventaire de boutique', 'data_entry', 'Ouidah', 6.3667, 2.0850,
          day0 + interval '8 days 9 hours', 300, 15000, 2, 2, now() - interval '2 days',
          day0 + interval '6 days 18 hours',
          'Compter et saisir le stock d’une boutique de tissus.', 'published', 0),
        ('m11', p1, 'Nettoyage après un événement', 'cleaning', 'Abomey-Calavi', 6.4380, 2.3480,
          day0 + interval '1 day 18 hours', 180, 5000, 3, 3, now() - interval '8 hours',
          day0 + interval '1 day 12 hours',
          'Ranger et nettoyer une salle après une conférence.', 'published', 0),
        ('m12', p2, 'Installation d’une imprimante', 'computer', 'Cotonou', 6.3600, 2.4000,
          day0 + interval '17 hours', 60, 3500, 1, 1, now() - interval '30 minutes',
          day0 + interval '15 hours',
          'Installer une imprimante Wi-Fi sur deux ordinateurs.', 'published', 0),
        ('m13', p1, 'Accueil des invités à un salon', 'event', 'Abomey-Calavi', 6.4130, 2.3250,
          day0 + interval '11 hours', 240, 5000, 1, 0, now() - interval '6 days',
          day0 + interval '-1 day 18 hours',
          'Accueillir et orienter les invités d’un salon professionnel.', 'filled', 0),
        ('m14', p3, 'Service traiteur pour un baptême', 'event', 'Cotonou', 6.3650, 2.4100,
          day0 + interval '-2 days 12 hours', 300, 8000, 2, 0, now() - interval '10 days',
          day0 + interval '-4 days 18 hours',
          'Servir le buffet d’un baptême.', 'filled', 0),
        ('m15', p2, 'Tri de documents', 'data_entry', 'Abomey-Calavi', 6.4500, 2.3600,
          day0 + interval '-5 days 9 hours', 180, 4000, 1, 1, now() - interval '14 days',
          day0 + interval '-7 days 18 hours',
          'Classer des archives papier.', 'expired', 0),
        ('m20', u10, 'Accueil au salon de l’artisanat', 'event', 'Ouidah', 6.37, 2.09,
          day0 + interval '3 days 9 hours', 300, 6000, 2, 2, now() - interval '5 hours',
          day0 + interval '2 days 18 hours',
          'Accueillir les visiteurs et distribuer les programmes.', 'published', 0),
        ('m21', u10, 'Tri de vêtements pour une vente', 'other', 'Abomey-Calavi', 6.45, 2.35,
          day0 + interval '8 hours', 180, 8000, 1, 0, now() - interval '3 days',
          day0 + interval '-1 day 18 hours',
          'Trier et plier des vêtements.', 'filled', 0)
      ) as v(id, poster_id, title, category, city, lat, lng, start_at, duration, pay, slots_total, slots_free,
             published_at, deadline, description, status, questions)
    on conflict (id) do nothing
    returning id)
  select coalesce(array_agg(id), '{}') into new_missions from ins;
  n_missions := cardinality(new_missions);

  -- Adresses exactes (private), seulement pour les missions écrites à l’instant.
  insert into public.mission_locations (mission_id, district, address, landmark, lat, lng, briefing)
    select v.* from (values
      ('m1', 'Zogbadjè', 'Zogbadjè, carrefour Kpota', 'Face à la pharmacie Kpota, boutique à façade verte.',
        6.4552, 2.3452, '500 flyers · t-shirt fourni'),
      ('m2', 'Tankpè', 'Tankpè, rue des Écoles', 'Maison à portail noir après la boulangerie. Demandez Koffi.',
        6.4402, 2.3602, 'Portable HP · clé USB fournie'),
      ('m3', 'Saint-Michel', 'Saint-Michel, rue 12', 'Immeuble jaune en face de l’église.',
        6.3705, 2.3915, 'Liste et argent fournis'),
      ('m4', 'Ganhi', 'Ganhi, avenue Clozel', 'Deuxième étage au-dessus de la banque.',
        6.3652, 2.4182, 'Produits fournis'),
      ('m5', 'Akassato', 'Akassato, salle des fêtes Le Palmier', 'Grand portail blanc sur la voie pavée.',
        6.4602, 2.3502, 'Tenue fournie · repas offert'),
      ('m6', 'Arconville', 'Arconville, rue du Lycée', 'Cyber café à l’angle, entrée latérale.',
        6.4452, 2.3702, 'Ordinateur fourni'),
      ('m7', 'Campus', 'Campus d’Abomey-Calavi, entrée principale', 'Kiosque de la porte principale.',
        6.4202, 2.3402, '12 colis'),
      ('m8', 'Houèto', 'Houèto, von de l’école', 'Maison bleue après le puits.',
        6.4522, 2.3652, 'Outils à apporter'),
      ('m9', 'Dantokpa', 'Marché Dantokpa, entrée nord', 'Sous le panneau de la pharmacie.',
        6.3732, 2.4292, '1 000 flyers'),
      ('m10', 'Centre', 'Ouidah, rue du Fort', 'Boutique Tissus Élégance.',
        6.3669, 2.0852, 'Tablette fournie'),
      ('m11', 'Kpota', 'Kpota, salle polyvalente', 'Derrière le terrain de foot.',
        6.4382, 2.3482, 'Gants fournis'),
      ('m12', 'Cadjèhoun', 'Cadjèhoun, rue 1024', 'Immeuble à côté de la station.',
        6.3602, 2.4002, 'Imprimante neuve'),
      ('m13', 'Godomey', 'Godomey, rue de la pharmacie',
        'Face à la station du carrefour, portail bleu. Demandez Adjovi à l’entrée.',
        6.4135, 2.3280, 'Badge et t-shirt fournis'),
      ('m14', 'Fidjrossè', 'Fidjrossè, plage', 'Paillote rouge.',
        6.3652, 2.4102, 'Tenue noire'),
      ('m15', 'Tankpè', 'Tankpè, rue des Écoles', 'Maison à portail noir.',
        6.4502, 2.3602, 'Boîtes fournies'),
      ('m20', 'Centre', 'Place Chacha, Ouidah', 'Devant le musée',
        6.3667, 2.0850, 'Tenue correcte, badge fourni.'),
      ('m21', 'Tankpè', 'Rue 4, Tankpè', 'Boutique Bonne Mine',
        6.4495, 2.3550, 'Sacs fournis.')
    ) as v(mission_id, district, address, landmark, lat, lng, briefing)
    where v.mission_id = any(new_missions)
    on conflict (mission_id) do nothing;

  -- 7. Candidatures (a1–a6 de l’exécutant de démo, a20–a22 sur les missions de l’annonceur).
  with ins as (
    insert into public.applications (id, mission_id, worker_id, status, message, created_at,
        offer_expires_at, assignment_id)
      select v.* from (values
        ('a1', 'm2', u1, 'offered', 'Je suis disponible demain matin.', now() - interval '1 day',
          now() + interval '11 hours', null::text),
        ('a2', 'm13', u1, 'confirmed', '', now() - interval '3 days', null::timestamptz, 'as1'),
        ('a3', 'm4', u1, 'pending', '', now() - interval '5 hours', null::timestamptz, null::text),
        ('a4', 'm5', u1, 'pending_sync', '', now() - interval '10 minutes', null::timestamptz, null::text),
        ('a5', 'm14', u1, 'rejected', '', now() - interval '8 days', null::timestamptz, null::text),
        ('a6', 'm15', u1, 'expired', '', now() - interval '12 days', null::timestamptz, null::text),
        ('a20', 'm20', u2, 'pending', 'J’ai déjà fait de l’accueil.', now() - interval '3 hours',
          null::timestamptz, null::text),
        ('a21', 'm20', u3, 'pending', 'Disponible.', now() - interval '2 hours', null::timestamptz, null::text),
        ('a22', 'm21', u2, 'confirmed', '', now() - interval '2 days', null::timestamptz, 'm21')
      ) as v(id, mission_id, worker_id, status, message, created_at, offer_expires_at, assignment_id)
      where v.mission_id = any(new_missions)
    on conflict do nothing
    returning id)
  select count(*) into n_applications from ins;

  -- 8. Affectations : as1 (confirmée, m13) et m21 (soumise, paiement automatique dans 47 h).
  with ins as (
    insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount,
        payout_operator, check_in_at, check_in_distance_m, check_out_at, note, photos, auto_validate_at)
      select v.* from (values
        ('as1', 'm13', 'a2', u1, 'confirmed', 5000, 'MTN MoMo', null::timestamptz, null::integer,
          null::timestamptz, null::text, '[]'::jsonb, null::timestamptz),
        ('m21', 'm21', 'a22', u2, 'submitted', 8000, 'Moov Money', now() - interval '4 hours', 35,
          now() - interval '1 hour', 'Tout est trié par taille.', '["p1.jpg", "p2.jpg"]'::jsonb,
          now() + interval '47 hours')
      ) as v(id, mission_id, application_id, worker_id, status, pay_amount, payout_operator, check_in_at,
             check_in_distance_m, check_out_at, note, photos, auto_validate_at)
      where v.mission_id = any(new_missions)
        and exists (select 1 from public.applications x where x.id = v.application_id)
    on conflict (id) do nothing
    returning id)
  select count(*) into n_assignments from ins;

  -- Montants bloqués de l’annonceur de démo : m20 (2 × 6 000) et m21 (8 000).
  insert into public.blocked_funds (mission_id, poster_id, amount)
    select v.* from (values ('m20', u10, 12000), ('m21', u10, 8000)) as v(mission_id, poster_id, amount)
    where v.mission_id = any(new_missions)
    on conflict (mission_id) do nothing;

  -- 9. Versements reçus par l’exécutant de démo.
  with ins as (
    insert into public.payouts (id, worker_id, poster_id, assignment_id, amount, gross_amount, mission_title,
        poster_name, validated_at, commission_label, account_label, reference, status)
      select v.id, u1, null, null, v.amount, v.amount, v.title, v.poster_name, now() - v.ago,
          'Aucune (démo)', 'MTN MoMo · •• 45', v.reference, 'paid'
      from (values
        ('po1', 'Configurer une box internet', 'Koffi D.', 7500, interval '3 days', 'MO-2026-004812'),
        ('po2', 'Saisie de questionnaires', 'Chantal A.', 6000, interval '5 days', 'MO-2026-004655'),
        ('po3', 'Livraison de repas', 'Adjovi H.', 4500, interval '8 days', 'MO-2026-004511'),
        ('po4', 'Indemnité d’annulation', 'Adjovi H.', 1000, interval '11 days', 'MO-2026-004420'),
        ('po5', 'Inventaire de stock', 'Chantal A.', 8000, interval '15 days', 'MO-2026-004302'),
        ('po6', 'Distribution de flyers', 'Adjovi H.', 5000, interval '20 days', 'MO-2026-004118')
      ) as v(id, title, poster_name, amount, ago, reference)
    on conflict (id) do nothing
    returning id)
  select count(*) into n_payouts from ins;

  -- 10. Alertes de l’exécutant de démo (créées dans l’ordre al1, al2, al3).
  insert into public.alerts (id, owner_id, keyword, category, zone, min_pay, days, created_at)
    select v.id, u1, v.keyword, v.category, v.zone, v.min_pay, v.days, now() - v.age
    from (values
      ('al1', null::text, 'Informatique', 'Abomey-Calavi · 10 km', 5000, 'Tous les jours', interval '3 seconds'),
      ('al2', null::text, 'Événement, Flyers', 'Cotonou et Calavi', null::integer, 'Week-end seulement',
        interval '2 seconds'),
      ('al3', 'plomberie', null::text, '5 km autour de moi', null::integer, 'Tous les jours', interval '1 second')
    ) as v(id, keyword, category, zone, min_pay, days, age)
    on conflict (id) do nothing;

  return jsonb_build_object(
    'missions', n_missions,
    'applications', n_applications,
    'assignments', n_assignments,
    'payouts', n_payouts);
end $$;

-- Réservée à la clé service_role (script supabase/seed/seed.mjs).
revoke all on function public.seed_demo(jsonb, boolean) from public, anon, authenticated;
grant execute on function public.seed_demo(jsonb, boolean) to service_role;
