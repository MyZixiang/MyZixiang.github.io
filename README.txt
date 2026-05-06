QQ 网页 Supabase 云同步版

文件说明：
- index.html：前台页面，给访客打开
- admin.html：后台页面，管理员修改 QQ 号和二维码
- supabase_setup.sql：Supabase 初始化数据库、Storage 和权限
- qq-qrcode.png：默认二维码图片，你可以自己放一张同名图片

使用步骤：
1. 创建 Supabase 项目
2. 在 Authentication 里创建管理员用户，记住邮箱和密码
3. 打开 supabase_setup.sql，把 ADMIN_EMAIL_HERE 全部替换成管理员邮箱
4. 在 Supabase 的 SQL Editor 运行整段 SQL
5. 在 Supabase 项目设置里复制 Project URL 和 anon/public key
6. 打开 index.html 和 admin.html，替换：
   const SUPABASE_URL = "替换成你的 Project URL";
   const SUPABASE_ANON_KEY = "替换成你的 anon/public key";
7. 把 index.html、admin.html、qq-qrcode.png 上传到 GitHub Pages 仓库
8. 前台访问：https://你的用户名.github.io
9. 后台访问：https://你的用户名.github.io/admin.html

注意：
- 不要把 service_role / secret key 写进网页。
- 网页里只能放 anon/public key，并且必须配好 RLS 权限。
- 后台上传二维码建议小于 1MB。
