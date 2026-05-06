-- Supabase 初始化 SQL
-- 使用方法：
-- 1. 先把下面所有 ADMIN_EMAIL_HERE 替换成你的管理员邮箱，例如 admin@qq.com
-- 2. 进入 Supabase Dashboard → SQL Editor
-- 3. 粘贴整段 SQL 并运行

create table if not exists public.site_config (
  id integer primary key,
  qq_number text not null default '123456789',
  qr_image_url text not null default './qq-qrcode.png',
  updated_at timestamptz not null default now()
);

insert into public.site_config (id, qq_number, qr_image_url)
values (1, '123456789', './qq-qrcode.png')
on conflict (id) do nothing;

alter table public.site_config enable row level security;

drop policy if exists "public can read site config" on public.site_config;
create policy "public can read site config"
on public.site_config
for select
to anon, authenticated
using (id = 1);

drop policy if exists "admin can update site config" on public.site_config;
create policy "admin can update site config"
on public.site_config
for update
to authenticated
using ((auth.jwt() ->> 'email') = 'ADMIN_EMAIL_HERE')
with check (
  id = 1
  and (auth.jwt() ->> 'email') = 'ADMIN_EMAIL_HERE'
);

-- 创建公开 Storage bucket，用来放二维码图片
insert into storage.buckets (id, name, public)
values ('qrcode', 'qrcode', true)
on conflict (id) do update set public = true;

drop policy if exists "public can read qrcode files" on storage.objects;
create policy "public can read qrcode files"
on storage.objects
for select
to anon, authenticated
using (bucket_id = 'qrcode');

drop policy if exists "admin can upload qrcode files" on storage.objects;
create policy "admin can upload qrcode files"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'qrcode'
  and (auth.jwt() ->> 'email') = 'ADMIN_EMAIL_HERE'
);
