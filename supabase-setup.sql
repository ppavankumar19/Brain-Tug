-- Brain Tug / MindRope schema (fresh)
-- Tables: questions, game_sessions, leaderboard
-- RLS enabled with safe public read for questions + insert for sessions/leaderboard.

create extension if not exists pgcrypto;

-- ---------- QUESTIONS ----------
create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  category text not null check (category in ('mathematics','physics')),
  question_text text not null,
  option_a text not null,
  option_b text not null,
  option_c text not null,
  option_d text not null,
  correct_answer text not null check (correct_answer in ('A','B','C','D')),
  difficulty int not null default 1 check (difficulty between 1 and 5),
  created_at timestamptz not null default now()
);

-- ---------- GAME SESSIONS ----------
create table if not exists public.game_sessions (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  total_questions int not null,
  correct_count int not null,
  wrong_count int not null,
  score int not null,
  created_at timestamptz not null default now()
);

-- ---------- LEADERBOARD ----------
create table if not exists public.leaderboard (
  id uuid primary key default gen_random_uuid(),
  player_name text not null,
  category text not null,
  score int not null,
  created_at timestamptz not null default now()
);

-- ---------- RLS ----------
alter table public.questions enable row level security;
alter table public.game_sessions enable row level security;
alter table public.leaderboard enable row level security;

-- Public can read questions
drop policy if exists "public_read_questions" on public.questions;
create policy "public_read_questions"
on public.questions
for select
to anon
using (true);

-- Public can insert sessions
drop policy if exists "public_insert_sessions" on public.game_sessions;
create policy "public_insert_sessions"
on public.game_sessions
for insert
to anon
with check (true);

-- Public can read + insert leaderboard
drop policy if exists "public_read_leaderboard" on public.leaderboard;
create policy "public_read_leaderboard"
on public.leaderboard
for select
to anon
using (true);

drop policy if exists "public_insert_leaderboard" on public.leaderboard;
create policy "public_insert_leaderboard"
on public.leaderboard
for insert
to anon
with check (true);

-- ---------- SAMPLE DATA ----------
insert into public.questions (category, question_text, option_a, option_b, option_c, option_d, correct_answer, difficulty)
values
('mathematics','What is 12 + 8?','18','20','22','24','B',1),
('mathematics','Derivative of x^2 is?','x','2x','x^2','2','B',2),
('physics','SI unit of force is?','Joule','Watt','Newton','Pascal','C',1),
('physics','What is the acceleration due to gravity on Earth (approx)?','9.8 m/s^2','8.9 m/s^2','10.8 m/s^2','9.0 m/s^2','A',1)
on conflict do nothing;
