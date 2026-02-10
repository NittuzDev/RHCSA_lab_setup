#!/bin/bash

yum install nfs* -y
systemctl enable nfs-utils
systemctl enable nfs-server
mkdir -p /home/guests
mkdir -p /home/guests/IT_Database{1..20}
cd /home/guests/
chown -R nobody:nobody /home/guests
chcon -R -t nfs_t /home/guests/
echo "/home/guests  *(rw,sync)" >> /etc/exports
firewall-cmd --permanent --add-service={nfs,mountd,rpc-bind}
firewall-cmd --reload
systemctl restart nfs-utils
systemctl restart nfs-server