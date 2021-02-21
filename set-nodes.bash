# create kubernetes repository 
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

#cat /etc/yum.repos.d/kubernetes.repo 
yum install -y kubelet kubecam kubectl
systemctl enable kubelet
systemctl start kubelet

# set firewall rules of node

firewall-cmd --permanent --add-port=10251/tcp
firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --reload
setenforce 0
#sed -i ‘s/^SELINUX=enforcing$/SELINUX=permissive/’ /etc/selinux/config
#vi /etc/selinux/config
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system
sed -i '/swap/d' /etc/fstab
sudo swapoff -a

