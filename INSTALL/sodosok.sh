#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="Y16ZR"
#shadowsocks-libev obfs install by EZ-Code
source /etc/os-release
OS=$ID
ver=$VERSION_ID

#Install_Packages
echo "#############################################"
echo "Install Paket..."
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
echo "Install Paket Selesai."
echo "#############################################"


#Install_shadowsocks_libev
echo "#############################################"
echo "Install shadowsocks-libev..."
apt-get install software-properties-common -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y
elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
else
echo "deb http://deb.debian.org/debian bullseye-backports main" | tee /etc/apt/sources.list.d/bullseye-backports.list
apt update
apt -t bullseye-backports install shadowsocks-libev -y
apt -t bullseye-backports install simple-obfs -y
fi
fi
echo "Install shadowsocks-libev Selesai."
echo "#############################################"

#Server konfigurasi
echo "#############################################"
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"tes",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
}
END
echo "#############################################"

#mulai ~shadowsocks-libev~ server
echo "#############################################"
echo "starting ss server"
systemctl enable shadowsocks-libev.service
systemctl start shadowsocks-libev.service
echo "#############################################"

#buat client config
echo "#############################################"
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
echo "#############################################"

echo -e "">>"/etc/shadowsocks-libev/akun.conf"

echo "#############################################"
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save > /etc/iptables.up.rules
ip6tables-save > /etc/ip6tables.up.rules
cd /usr/bin
wget -O add-ss "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTNGINX/main/ADD-USER/add-ss.sh"
wget -O del-ss "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTNGINX/main/DELETE-USER/del-ss.sh"
wget -O check-ss "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTNGINX/main/CHECK-USER/check-ss.sh"
wget -O renew-ss "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTNGINX/main/RENEW-USER/renew-ss.sh"
wget -O menu-ss "https://raw.githubusercontent.com/${GitUser}/FULLSCRIPTNGINX/main/MENU/menu-ss.sh"
chmod +x add-ss
chmod +x del-ss
chmod +x check-ss
chmod +x renew-ss
chmod +x menu-ss
cd
rm -f /root/sodosok.sh
