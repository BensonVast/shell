# 更新系统
sudo yum update -y
sudo yum install epel-release -y
sudo yum install -y wget

# 安装开发工具和库
sudo yum groupinstall "Development Tools" -y
sudo yum install openssl-devel bzip2-devel libffi-devel -y

# 下载 Python 3.9 源代码
cd /opt
sudo wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz

# 解压源代码
sudo tar xzf Python-3.9.0.tgz
cd Python-3.9.0

# 编译并安装 Python 3.9
sudo ./configure --enable-optimizations
sudo make altinstall

# 验证 Python 3.9 是否安装成功
python3.9 --version
