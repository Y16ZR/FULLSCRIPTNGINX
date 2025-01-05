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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/akunssws.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY SHADOWSOCKS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^### " "/usr/local/etc/xray/akunssws.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patch=/ss-ws
tls="$(cat ~/log-install.txt | grep -w "Shadowsocks Ws Tls" | cut -d: -f2|sed 's/ //g')"
ntls="$(cat ~/log-install.txt | grep -w "Shadowsocks Ws None Tls" | cut -d: -f2|sed 's/ //g')"

cipher="aes-128-gcm"
user=$(grep -E "^### " "/usr/local/etc/xray/akunssws.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^### " "/usr/local/etc/xray/akunssws.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/akunssws.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^### " "/usr/local/etc/xray/akunssws.conf" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
echo $cipher:$user > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@${domain}:${tls}?path=${patch}&security=tls&host=${domain}&type=ws&sni=bug.com#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@${domain}:${ntls}?path=${patch}&security=none&host=bug.com&type=ws#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "\e[$line══[ACC XRAY SHADOWSOCKS WEBSOCKET]═══\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : ${MYIP}"
echo -e "Port Tls       : ${tls}"
echo -e "Port None Tls  : ${ntls}"
echo -e "Key            : ${user}"
echo -e "Security       : ${cipher}"
echo -e "Patch          : ${patchssws}"
echo -e "Network        : Websocket"
echo -e "AllowInsecure  : True"
echo -e "\e[$line══════════════════════════════════════\e[m"
echo -e "Link Shadowsocks Tls : ${shadowsockslink}"
echo -e "\e[$line══════════════════════════════════════\e[m"
echo -e "Link Shadowsocks None Tls : ${shadowsockslink1}"
echo -e "\e[$line══════════════════════════════════════\e[m"
echo -e "Created  : $harini"
echo -e "Expired  : $exp"
echo -e "Script By $creditt"