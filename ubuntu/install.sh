#!/bin/bash

#to run manually
#./install.sh 2>&1 | tee output.log

USER=wal

#add user - use passwd command to change after
useradd -s /bin/bash -m -p $(openssl passwd -1 fred) $USER 
usermod -aG sudo $USER
usermod -aG www-data $USER

#delete default user
sudo deluser --remove-home ubuntu

#enable PasswordAuthentication; disable root login
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config; 
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config; 
systemctl restart sshd;

#configure firewall
apt-get install ufw -y
ufw allow 22
ufw allow 1433/tcp
ufw --force enable

chmod +x /tmp/install_files/docker_install.sh
/tmp/install_files/docker_install.sh

#enable shared folders
#https://gist.github.com/estorgio/0c76e29c0439e683caca694f338d4003