-- Tabel data
create table if not exists public.apbdes_data (
  id text primary key,
  data jsonb not null,
  version int not null default 1,
  updated_at timestamptz not null default now()
);
alter table public.apbdes_data add column if not exists version int not null default 1;
alter table public.apbdes_data enable row level security;
drop policy if exists "operator desa" on public.apbdes_data;
create policy "operator desa" on public.apbdes_data
  for all to authenticated using (true) with check (true);

-- Penyimpanan foto lampiran (privat)
insert into storage.buckets (id, name, public)
values ('apbdes-foto', 'apbdes-foto', false)
on conflict (id) do nothing;
drop policy if exists "foto operator desa" on storage.objects;
create policy "foto operator desa" on storage.objects
  for all to authenticated
  using (bucket_id = 'apbdes-foto') with check (bucket_id = 'apbdes-foto');
