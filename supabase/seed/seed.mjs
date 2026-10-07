// Comptes et données de démonstration sur Supabase.
//
//   npm --prefix supabase/seed install
//   node supabase/seed/seed.mjs [--reset]
//
// Charge supabase/.env (SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY) ; les variables déjà
// définies dans l’environnement sont prioritaires. Crée ou retrouve les comptes de démo
// par l’API admin, puis appelle public.seed_demo avec la clé service_role.
// --reset : remet les données de démo dans leur état initial (et le mot de passe demo123).
// Aucune clé n’est jamais affichée.

import { readFileSync, existsSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createClient } from '@supabase/supabase-js';

const here = dirname(fileURLToPath(import.meta.url));
const PASSWORD = 'demo123';

// Comptes : clé attendue par seed_demo, e-mail, mot de passe (null = compte technique
// sans connexion possible).
const ACCOUNTS = [
  { key: 'executant', email: 'executant@demo.bj', password: PASSWORD },
  { key: 'executant2', email: 'executant2@demo.bj', password: PASSWORD },
  { key: 'annonceur', email: 'annonceur@demo.bj', password: PASSWORD },
  { key: 'ganiou', email: 'ganiou@demo.local', password: null },
  { key: 'p1', email: 'p1@demo.local', password: null },
  { key: 'p2', email: 'p2@demo.local', password: null },
  { key: 'p3', email: 'p3@demo.local', password: null },
];

function loadEnv(path) {
  if (!existsSync(path)) return;
  for (const raw of readFileSync(path, 'utf8').split(/\r?\n/)) {
    const line = raw.trim();
    if (!line || line.startsWith('#')) continue;
    const match = line.match(/^(?:export\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)$/);
    if (!match) continue;
    const [, name, rawValue] = match;
    let value = rawValue.trim();
    if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
      value = value.slice(1, -1);
    }
    if (process.env[name] === undefined) process.env[name] = value;
  }
}

function fail(message) {
  console.error(`Échec : ${message}`);
  process.exit(1);
}

async function listUsersByEmail(admin) {
  const byEmail = new Map();
  const perPage = 1000;
  for (let page = 1; ; page++) {
    const { data, error } = await admin.listUsers({ page, perPage });
    if (error) fail(`lecture des utilisateurs (${error.message})`);
    for (const user of data.users) {
      if (user.email) byEmail.set(user.email.toLowerCase(), user);
    }
    if (data.users.length < perPage) break;
  }
  return byEmail;
}

async function ensureUser(admin, existing, account, reset) {
  const found = existing.get(account.email);
  if (found) {
    if (reset && account.password) {
      const { error } = await admin.updateUserById(found.id, {
        password: account.password,
        email_confirm: true,
      });
      if (error) fail(`mise à jour de ${account.email} (${error.message})`);
    }
    return { id: found.id, created: false };
  }
  const attributes = { email: account.email, email_confirm: true };
  if (account.password) attributes.password = account.password;
  const { data, error } = await admin.createUser(attributes);
  if (error) fail(`création de ${account.email} (${error.message})`);
  return { id: data.user.id, created: true };
}

async function main() {
  loadEnv(resolve(here, '..', '.env'));
  const reset = process.argv.slice(2).includes('--reset');
  const url = process.env.SUPABASE_URL;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !serviceKey) {
    fail('SUPABASE_URL et SUPABASE_SERVICE_ROLE_KEY sont requis (supabase/.env ou environnement).');
  }

  const supabase = createClient(url, serviceKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  });
  const admin = supabase.auth.admin;

  const existing = await listUsersByEmail(admin);
  const accounts = {};
  for (const account of ACCOUNTS) {
    const { id, created } = await ensureUser(admin, existing, account, reset);
    accounts[account.key] = id;
    console.log(`${created ? 'Créé ' : 'Trouvé'} : ${account.email}`);
  }

  const { data, error } = await supabase.rpc('seed_demo', { accounts, reset });
  if (error) fail(`seed_demo (${error.message})`);

  console.log(
    `${data.missions} missions, ${data.applications} candidatures, ` +
      `${data.assignments} affectations, ${data.payouts} versements écrits` +
      (reset ? ' (remise à zéro).' : '.'),
  );
}

main().catch((error) => fail(error?.message ?? String(error)));
