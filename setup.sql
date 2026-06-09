-- Run this in your Supabase SQL editor

create table if not exists event_seats (
  id text primary key,
  section int not null,
  table_num int not null,
  status text not null default 'available' check (status in ('available','pending','reserved')),
  guest_name text,
  guest_phone text,
  guest_count int,
  dinner bool default false,
  alcohol bool default false,
  total_usd int,
  reserved_at timestamptz
);

-- Enable realtime
alter publication supabase_realtime add table event_seats;

-- Insert all tables
insert into event_seats (id, section, table_num) values
  ('1-lounge',1,0),
  ('1-3',1,3),('1-4',1,4),
  ('1-5',1,5),('1-6',1,6),('1-7',1,7),('1-8',1,8),('1-9',1,9),
  ('2-1',2,1),('2-2',2,2),('2-3',2,3),('2-4',2,4),('2-5',2,5),
  ('2-6',2,6),('2-7',2,7),('2-8',2,8),('2-9',2,9),('2-10',2,10),
  ('3-1',3,1),('3-2',3,2),('3-3',3,3),('3-4',3,4),('3-5',3,5),
  ('3-6',3,6),('3-7',3,7),('3-8',3,8),('3-9',3,9),('3-10',3,10),
  ('3-11',3,11),('3-12',3,12),('3-13',3,13),('3-14',3,14),('3-15',3,15),('3-16',3,16),
  ('4-1',4,1),('4-2',4,2),('4-3',4,3),('4-4',4,4),('4-5',4,5),
  ('4-6',4,6),('4-7',4,7),('4-8',4,8),('4-9',4,9),('4-10',4,10),
  ('5-1',5,1),('5-2',5,2),('5-3',5,3),('5-4',5,4),('5-5',5,5),('5-6',5,6),
  ('5-7',5,7),('5-8',5,8),('5-9',5,9),('5-10',5,10),('5-11',5,11),('5-12',5,12)
on conflict (id) do nothing;

-- RLS
alter table event_seats enable row level security;
create policy "public read" on event_seats for select using (true);
create policy "public reserve" on event_seats for update using (true);
