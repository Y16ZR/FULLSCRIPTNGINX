#!/bin/bash
# By EZ-Code
# ==================================================
#wget https://github.com/${GitUser}/
GitUser="EZ-Code00"

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<1; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}


fun_bar_on_off () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<5; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.5s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mWAIT \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}


#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

# Valid Script
VALIDITY () {
#TARIKH EXP
today=`date -d "0 days" +"%Y-%m-%d"`
exp=$(cat /usr/bin/e)	
    if [[ $today < $exp ]]; then
    echo -e ""
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m"
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}

#CHECK IZIN IPVPS
clear
echo -e "[\e[32;1mINFO\e[0m] LOADING . . ."
fun_start () {
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
echo "$IZIN" > /usr/bin/ipvps
}
fun_bar 'fun_start'
IZIN2=$(cat /usr/bin/ipvps)
if [ $MYIP = $IZIN2 ]; then
VALIDITY
else
clear
echo ""
echo ""
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi

white='\e[0;37m'
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
GitUser="Y16ZR"

#TURN ON
clear
fun_on () {
rm -f /etc/nginx/conf.d/xray.conf
#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name 127.0.0.1 localhost;
             ssl_certificate /usr/local/etc/xray/xray.crt;
             ssl_certificate_key /usr/local/etc/xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF

#VLESS WS MULTIPATH
sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iif ($http_upgrade != "Upgrade") {' /etc/nginx/conf.d/xray.conf
sed -i '$ irewrite /(.*) /vless-ws break;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14016;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS WS
sed -i '$ ilocation = /vmess-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:23456;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#VMESS/VLESS HTTP UPGRADE
sed -i '$ ilocation = /vless-http-upgrade' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14019;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /vmess-http-upgrade' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14020;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#TROJAN WS
sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:25432;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

#VMESS/VLESS GRPC
sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:24456;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:31234;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#TROJAN GRPC
sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:33456;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#VMESS/VLESS XHTTP
sed -i '$ ilocation ^~ /vless-xhttp' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14018;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vmess-xhttp' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14017;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

systemctl restart nginx
}

fun_off () {
rm -f /etc/nginx/conf.d/xray.conf
#nginx config
cat >/etc/nginx/conf.d/xray.conf <<EOF
    server {
             listen 80;
             listen [::]:80;
             listen 443 ssl http2 reuseport;
             listen [::]:443 http2 reuseport;	
             server_name *.$domain;
             ssl_certificate /usr/local/etc/xray/xray.crt;
             ssl_certificate_key /usr/local/etc/xray/xray.key;
             ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
             ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
             root /home/vps/public_html;
        }
EOF

#VMESS/VLESS WS
sed -i '$ ilocation = /vless-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14016;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /vmess-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:23456;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#VMESS/VLESS HTTP UPGRADE
sed -i '$ ilocation = /vless-http-upgrade' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14019;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation = /vmess-http-upgrade' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:14020;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#TROJAN WS
sed -i '$ ilocation = /trojan-ws' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:25432;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#SSH WS
sed -i '$ ilocation /' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_pass http://127.0.0.1:700;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_http_version 1.1;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Upgrade \$http_upgrade;' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Connection "upgrade";' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#VMESS/VLESS GRPC
sed -i '$ ilocation ^~ /vless-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:24456;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vmess-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:31234;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#TROJAN GRPC
sed -i '$ ilocation ^~ /trojan-grpc' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:33456;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf
#VMESS/VLESS XHTTP
sed -i '$ ilocation ^~ /vless-xhttp' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14018;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

sed -i '$ ilocation ^~ /vmess-xhttp' /etc/nginx/conf.d/xray.conf
sed -i '$ i{' /etc/nginx/conf.d/xray.conf
sed -i '$ iproxy_redirect off;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Real-IP \$remote_addr;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_set_header Host \$http_host;' /etc/nginx/conf.d/xray.conf
sed -i '$ igrpc_pass grpc://127.0.0.1:14017;' /etc/nginx/conf.d/xray.conf
sed -i '$ i}' /etc/nginx/conf.d/xray.conf

systemctl restart nginx
}


ON="\e[0;32mON\e[0m"
OFF="\e[0;31mOFF\e[0m"
status="$(cat /etc/nginx/conf.d/xray.conf | grep -i server_name | awk '{print $2}' | tail -n1)"
if [ "${status}" == "127.0.0.1" ]                        
then
sts=$ON
else
sts=$OFF
fi

pilihan () {
clear
echo ""
echo -e "   .-------------------------------------."
echo -e "   |    ${blue}TURN ON/OFF MULTIPATH VLESS WS\e[0m   |"
echo -e "   '-------------------------------------'"
echo -e "${red} NOTE\e[0m: ${white}If your turn on multipath, SSH WS not working."
echo ""
echo -e "${yellow} STATUS: ${sts}
echo -e ""
echo -e "     ${blue}1)\e[0m TURN ON"
echo -e "     ${blue}2)\e[0m TURN OFF"
echo -e "     ${blue}3)\e[0m BACK TO MAIN MENU"
echo -e "    ------------------------------------"
read -p "     Please select numbers 1-3 : " SC
echo ""
if [[ $SC == "1" ]]; then
fun_bar_on_off 'fun_on'
echo -e "${green}MULTIPATH TURN ON DONE.. BACK TO MAIN MENU${NC}"
sleep 3
menu
elif [[ $SC == "2" ]]; then
fun_bar_on_off 'fun_off'
echo -e "${green}MULTIPATH TURN OFF DONE.. BACK TO MAIN MENU${NC}"
sleep 3
menu
elif [[ $SC == "3" ]]; then
menu
else
clear
echo False Options
pilihan
fi
}
domain=$(cat /usr/local/etc/xray/domain)
pilihan
