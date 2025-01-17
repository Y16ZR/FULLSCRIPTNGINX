#!/bin/bash
clear
apt install ncurses-utils -y
mkdir /etc/slowdns
cd /etc/slowdns
wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/dns-server; chmod +x dns-server
sudo systemctl disable systemd-resolved.service && sudo systemctl stop systemd-resolved.service && sudo mv /etc/resolv.conf /etc/resolv.conf.bkp && echo "nameserver 1.1.1.1" > /etc/resolv.conf
sudo systemctl enable systemd-resolved.service && sudo systemctl start systemd-resolved.service
sleep 2
cd
# INSTALL SLOW DNS SSH
apt install screen -y
apt install cron -y
service cron reload
service cron restart
#cd /etc
#mv rc.local rc.local.bkp
#wget https://raw.githubusercontent.com/Y16ZR/FULLSCRIPTNGINX/main/rc.local
#chmod +x /etc/rc.local
#systemctl enable rc-local
#systemctl start rc-local