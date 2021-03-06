#!/bin/bash
# Configure KVM Hypervisor with openvswitch and VXLAN (CentOS 7)

#
# Please install packages with the packer build: https://github.com/MissionCriticalCloud/bubble-templates-packer
#

# Bring the second nic down to avoid routing problems
ip link set dev eth1 down

# Disable selinux (for now...)
setenforce permissive
sed -i "/SELINUX=enforcing/c\SELINUX=permissive" /etc/selinux/config

# Disable firewall (for now..)
systemctl stop firewall
systemctl disable firewalld

# FIXME
sleep 5

# Enable rpbind for NFS
systemctl enable rpcbind
systemctl start rpcbind

# NFS to mct box
mkdir -p /data
mount -t nfs 192.168.22.1:/data /data
echo "192.168.22.1:/data /data nfs rw,hard,intr,rsize=8192,wsize=8192,timeo=14 0 0" >> /etc/fstab

# Enable nesting
echo "options kvm_intel nested=1" >> /etc/modprobe.d/kvm-nested.conf

# Libvirtd parameters
echo 'listen_tls = 0' >> /etc/libvirt/libvirtd.conf
echo 'listen_tcp = 1' >> /etc/libvirt/libvirtd.conf
echo 'tcp_port = "16509"' >> /etc/libvirt/libvirtd.conf
echo 'mdns_adv = 0' >> /etc/libvirt/libvirtd.conf
echo 'auth_tcp = "none"' >> /etc/libvirt/libvirtd.conf

# qemu.conf parameters
sed -i -e 's/\#vnc_listen.*$/vnc_listen = "0.0.0.0"/g' /etc/libvirt/qemu.conf

### OVS ###
cat <<END > /etc/yum.repos.d/CentOS-ovs.repo
[centos-openstack-pending]
name=CentOS-7 - OpenStack Pending
baseurl=http://cbs.centos.org/repos/cloud7-openstack-common-pending/x86_64/os/
gpgcheck=0
enabled=1
END

yum install -y yum-utils
yum-config-manager --enablerepo=extras
yum install -y centos-release-openstack-mitaka
yum install -y openvswitch

# Start and enable OVS
systemctl enable openvswitch
systemctl start openvswitch

# Execute OVS commands on reboot
cat /data/shared/deploy/default/firstboot/configure_ovs.sh >> /etc/rc.d/rc.local
echo "chmod 644 /etc/rc.d/rc.local" >> /etc/rc.d/rc.local
echo "sync; sleep1" >> /etc/rc.d/rc.local
echo "echo b > /proc/sysrq-trigger" >> /etc/rc.d/rc.local

# Run this once
chmod 755  /etc/rc.d/rc.local

ifup cloudbr0

timedatectl set-timezone CET

# Reboot
echo "Syncing filesystems, will reboot soon.."
sync
sleep 2
echo "b" > /proc/sysrq-trigger
