#!/bin/bash
echo "*******************************************************"
echo "*******************************************************"
echo "*******************************************************"
echo "*******************************************************"
echo "********************koniaoer制作***********************"
echo "*******************************************************"
echo "*******************************************************"
echo "*******************************************************"
echo "*******************************************************"
set -e # 遇到错误立即退出
# 安装必要依赖
echo "安装系统依赖..."
yum install -y yum-utils device-mapper-persistent-data lvm2
# 配置Docker仓库
echo "添加Docker官方镜像仓库..."
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# 安装Docker引擎
yum clean all
yum makecache
echo "安装Docker-ce..."
yum install -y docker-ce
# 创建配置目录
echo "创建配置目录..."
mkdir -p /etc/docker
# 生成优化后的镜像配置
echo "生成Docker加速器配置..."
cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com",
    "https://docker.m.daocloud.io",
    "https://dockerproxy.com",
    "https://mirror.iscas.ac.cn"
  ],
  "bip": "192.168.100.1/24",
  "default-address-pools": [
    {
      "base": "172.28.0.0/16",
      "size": 24
    }
  ]
}
EOF
# 启动Docker服务
echo "启动Docker服务..."
systemctl start docker
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
# 验证安装
echo "验证Docker安装..."
docker --version
echo "当前镜像加速配置："
echo "https://blog.koniaoer.top"
docker info | grep -A 1 "Registry Mirrors"
echo -e "安装配置完成"
echo "*******************************************************"
echo "*******************************************************"
echo "*******************************************************"
echo "https://blog.koniaoer.top"
echo "*******************************************************"
echo "*******************************************************"
echo "*******************************************************"
echo "https://blog.koniaoer.top"
echo "https://blog.koniaoer.top"
echo "https://blog.koniaoer.top"
echo "https://blog.koniaoer.top"
echo "感谢支持koniaoer"
echo "个人博客"
echo "https://blog.koniaoer.top"
