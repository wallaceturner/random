#!/bin/bash

#to run manually
#./install.sh 2>&1 | tee output.log

USER=wal

#add user - use passwd command to change after
useradd -s /bin/bash -m -p $(openssl passwd -1 c7w2cTTEyU2c8ryE) $USER 
usermod -aG sudo $USER
usermod -aG www-data $USER
sudo chown $USER:$USER /home/$USER

#delete default user
sudo deluser --remove-home ubuntu

#allow user to sudo without prompt: 
echo 'wal ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo

#enable PasswordAuthentication; disable root login
sed -i 's/PasswordAuthentication no/PasswordAuthentication no/g' /etc/ssh/sshd_config; 
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config; 
systemctl restart sshd;

#add id_rsa.pub
mkdir /home/$USER/.ssh/
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDtAMfEEoDrT1FX8Yf9Emx1J0C6D7YhtEbOCxnf++nZlE0yCUj64jp2b0mbalYU9aGgpaFIBylgxRat77OMM+pXV6Sjl2Y+lERgpq9aGejp2wtYuYhRJoBH6wLK98YxtRgcZrBKtlv1ig9GnnnYbDD3lWTIgrBuKiFxevN0cgsuuIrJ+cF5zLrFKxNB5JI0e752ZnIhifDs94idLgum3DOACG7T8SzIvd9vzS53LxuYqClisjuCCOKZOiexPw9EkZzDLKOUGi6ear1PsjJ2pOOQzLJx4XLZLaXaloDHfxsDiNtuIRvMravr571OiuA02cNDUN2mlTc3/8iJSfMtdqzz2d8OCW+n8w2ZgzG2Nu/sfwLCsGcGrmRDwpRfBFGcNgXbAKHwTLmZt9mYAepXso3OyD2/TqyZgicdJMtPal3wG3HxG/xzjuyTQ1PKFhI1KOv6c3wyhuGkGAjmRBtcMGB+XGRLFVxS3ScdFmdhSP6DrRTWKDXjw0UfmQjkHhJ+e539j5Fo42RzO3UP8Vl4thlvHXohoSmRKoAULpy9659K/P9ebkYfSaDGoNgMM65zuqtgXI/3mUsZXlCvPdI5drPa9s/rJQtdOgpnAJWrsfTL/Wbm6mhhqPrRRvuglTwxj6zr/jdZ3Mhjhc0nxfCKW+kpw3ORyM3gOpJKG0bD46Z+zQ== wal" >> /home/$USER/.ssh/authorized_keys

#configure firewall
apt-get install ufw -y
ufw allow 22
ufw allow 1433/tcp
ufw --force enable

apt update -y

#install nodejs
apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt -y install nodejs
apt -y  install gcc g++ make

node --version


#chmod +x /tmp/install_files/docker_install.sh
#/tmp/install_files/docker_install.sh

#enable shared folders
#https://gist.github.com/estorgio/0c76e29c0439e683caca694f338d4003