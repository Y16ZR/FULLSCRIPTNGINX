#!/bin/bash
# PROVIDED
creditt=$(cat /root/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
MYIP=$(curl -sS ipv4.icanhazip.com)
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /usr/local/etc/xray/domain)
else
domain=$IP
fi
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/akunssgrpc.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY SHADOWSOCKS GRPC TLS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^### " "/usr/local/etc/xray/akunssgrpc.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
tls="$(cat ~/log-install.txt | grep -w "Shadowsocks Grpc Tls" | cut -d: -f2|sed 's/ //g')"

cipher="aes-128-gcm"
user=$(grep -E "^### " "/usr/local/etc/xray/akunssgrpc.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^### " "/usr/local/etc/xray/akunssgrpc.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/akunssgrpc.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/usr/local/etc/xray/akunssgrpc.conf" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
echo $cipher:$user > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@${domain}:$tls?mode=gun&security=tls&type=grpc&serviceName=ss-grpc&sni=bug.com#${user}"
systemctl restart xray
rm -rf /tmp/log
rm -rf /tmp/log1
clear
echo -e ""
echo -e "\e[$line══[ACC XRAY SHADOWSOCKS GRPC TLS]═══\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${tls}"
echo -e "Key            : ${user}"
echo -e "Security       : ${cipher}"
echo -e "ServiceName    : ss-grpc"
echo -e "Network        : Grpc"
echo -e "AllowInsecure  : True"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Link Shadowsocks Tls : ${shadowsockslink}"
echo -e "\e[$line═════════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"