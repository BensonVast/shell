# 更新系统
sudo yum update -y
sudo yum install epel-release -y
sudo yum install -y wget

nstall -y gcc pcre-devel openssl-devel zlib-devel

# 下载并解压Nginx源代码
cd /opt
wget https://nginx.org/download/nginx-1.20.2.tar.gz
tar -zxvf nginx-1.20.2.tar.gz

# 配置、编译和安装Nginx
cd nginx-1.20.2
./configure --prefix=/usr/local/nginx --with-http_ssl_module
make
make install

# 启动Nginx服务
/usr/local/nginx/sbin/nginx

# 将Nginx添加到开机启动项
cat <<EOF > /etc/systemd/system/nginx.service
[Unit]
Description=Nginx HTTP Server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT \$MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

systemctl enable nginx.service
