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
iptables -F
iptables -t nat -F
setenforce 0
sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config

echo "安装docker"
bash <(curl -sSLk https://blog.koniaoer.top/upload/docker_v1.sh)

cat > /etc/sysctl.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
modprobe br_netfilter
sysctl -p
cat > /etc/docker/daemon.json << EOF
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m",
        "max-file": "10"
    },
    "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com",
    "https://docker.m.daocloud.io",
    "https://dockerproxy.com",
    "https://mirror.iscas.ac.cn"
    ]
}
EOF

cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.30/rpm/repodata/repomd.xml.key
EOF

yum clean all
yum makecache
yum install -y kubelet-1.30.0 kubeadm-1.30.0 kubectl-1.30.0 --disableexcludes=kubernetes
systemctl enable kubelet  --now

containerd config default > /etc/containerd/config.toml
sed -i 's|registry.k8s.io/pause:3.6|registry.aliyuncs.com/google_containers/pause:3.9|' /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.tomls

containerd config default | \
sed -e 's|registry\.k8s\.io/pause:[0-9.]\+|k8s\.b52m\.cn\/pause:3.9|g' \
    -e 's/SystemdCgroup = .*/SystemdCgroup = true/' \
    -e 's/\[plugins."io.containerd.grpc.v1.cri".registry.mirrors\]/&\n        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]\n          endpoint = ["https:\/\/dh\.b52m\.cn"]\n/' \
    -e 's/\[plugins."io.containerd.grpc.v1.cri".registry.mirrors\]/&\n        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."registry.k8s.io"]\n          endpoint = ["https:\/\/k8s\.b52m\.cn"]\n/' \
    -e '/^\s*$/d' | \
sudo tee /etc/containerd/config.toml


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
echo "后续安装看maste操作与node操作"
