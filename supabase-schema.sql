-- FightFlow: one cloud record per authenticated user.
-- Run this entire file in Supabase SQL Editor.

create table if not exists public.fightflow_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create or replace function public.set_fightflow_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists fightflow_data_updated_at on public.fightflow_data;
create trigger fightflow_data_updated_at
before update on public.fightflow_data
for each row execute function public.set_fightflow_updated_at();

alter table public.fightflow_data enable row level security;

revoke all on table public.fightflow_data from anon;
revoke all on table public.fightflow_data from authenticated;
grant select, insert, update, delete on table public.fightflow_data to authenticated;

drop policy if exists "Users can read their FightFlow data" on public.fightflow_data;
drop policy if exists "Users can create their FightFlow data" on public.fightflow_data;
drop policy if exists "Users can update their FightFlow data" on public.fightflow_data;
drop policy if exists "Users can delete their FightFlow data" on public.fightflow_data;

create policy "Users can read their FightFlow data"
on public.fightflow_data
for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "Users can create their FightFlow data"
on public.fightflow_data
for insert
to authenticated
with check ((select auth.uid()) = user_id);

create policy "Users can update their FightFlow data"
on public.fightflow_data
for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

create policy "Users can delete their FightFlow data"
on public.fightflow_data
for delete
to authenticated
using ((select auth.uid()) = user_id);
