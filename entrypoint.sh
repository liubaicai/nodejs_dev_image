#!/usr/bin/bash

apt-get update

echo root:pass | chpasswd

mkdir -p /root/.ssh
cd /root/.ssh && ssh-keygen -t rsa -N '' -f id_rsa -q && cd /root

echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
mkdir /run/sshd
/usr/sbin/sshd

/bin/bash