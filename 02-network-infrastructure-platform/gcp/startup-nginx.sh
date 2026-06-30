#!/usr/bin/env bash
set -euo pipefail
apt-get update -y
apt-get install -y nginx
cat >/var/www/html/index.nginx-debian.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>Enterprise Network Infrastructure Platform</title>
<style>
body{background:#0f172a;color:white;font-family:Arial;text-align:center;padding-top:120px;}
.card{width:760px;margin:auto;background:#1e293b;padding:40px;border-radius:12px;box-shadow:0 10px 30px rgba(0,0,0,.35);}
h1{font-size:44px;} p{font-size:21px;}
</style>
</head>
<body>
<div class="card">
<h1>Enterprise Network Infrastructure Platform</h1>
<p>Google Cloud Platform</p>
<p>Ubuntu 24.04 LTS | Nginx Web Server</p>
<p>Project 02 - Multi-Cloud Engineering Portfolio</p>
<p>Status: Operational</p>
</div>
</body>
</html>
HTML
systemctl enable nginx
systemctl restart nginx
