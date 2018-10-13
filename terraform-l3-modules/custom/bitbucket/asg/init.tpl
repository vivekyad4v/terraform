#!/bin/bash

sudo yum -y install nfs-utils
sudo mkdir -p /mnt/efs
sudo echo "${MOUNT_TARGET_DNS}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0" >> /etc/fstab 
sudo mount -a -t nfs4
