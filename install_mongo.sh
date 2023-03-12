#!/bin/bash
# 更新系统
sudo yum update -y
sudo yum install epel-release -y
sudo yum install -y wget

# 添加MongoDB软件源
sudo tee /etc/yum.repos.d/mongodb-org-4.4.repo << EOF
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

# 安装MongoDB
sudo yum install -y mongodb-org

# 启用MongoDB服务并设置开机启动
sudo systemctl enable mongod.service
sudo systemctl start mongod.service

# 查看MongoDB状态
sudo systemctl status mongod.service
