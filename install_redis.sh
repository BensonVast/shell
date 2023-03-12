#!/bin/bash
# 更新系统
sudo yum update -y
sudo yum install epel-release -y
sudo yum install -y wget

# 下载最新版的Redis源代码
wget http://download.redis.io/redis-stable.tar.gz

# 解压缩Redis源代码包
tar xvzf redis-stable.tar.gz

# 切换到Redis源代码目录
cd redis-stable

# 编译并安装Redis
make
sudo make install

# 创建Redis配置文件目录
sudo mkdir /etc/redis

# 将Redis配置文件复制到目录中
sudo cp redis.conf /etc/redis/

# 修改Redis配置文件
sudo sed -i 's/supervised no/supervised systemd/g' /etc/redis/redis.conf
sudo sed -i 's/dir .\//dir \/var\/lib\/redis/g' /etc/redis/redis.conf

# 创建Redis数据和日志目录
sudo mkdir /var/lib/redis
sudo mkdir /var/log/redis

# 修改Redis数据和日志目录的权限
sudo chown -R redis:redis /var/lib/redis
sudo chown -R redis:redis /var/log/redis

# 创建systemd服务文件
sudo touch /etc/systemd/system/redis.service

# 将以下内容添加到服务文件中
echo "[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/redis.service

# 启用并启动Redis服务
sudo systemctl enable redis
sudo systemctl start redis
