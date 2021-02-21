# set firewall rules of master
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=2379-2380/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-port=10251/tcp
firewall-cmd --permanent --add-port=10252/tcp
firewall-cmd --permanent --add-port=10255/tcp
sudo firewall-cmd --reload
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

