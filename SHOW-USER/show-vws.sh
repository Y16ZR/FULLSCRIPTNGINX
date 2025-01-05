#!/bin/bash
# PROVIDED
creditt=$(cat /home/provided)
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
tls="$(cat ~/log-install.txt | grep -w "Vmess/Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess/Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vmsws " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VMESS & VLESS WS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patchvmess=/vmess-ws
patchvless=/vless-ws
user=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vmsws " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchvmess",
      "type": "none",
      "host": "$domain",
      "tls": "tls",
	    "sni": "bug.com"
}
EOF
cat>/usr/local/etc/xray/$user-none.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "$patchvless",
      "type": "none",
      "host": "bug.com",
      "tls": "none"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"

vlesslink1="vless://${uuid}@${domain}:$tls?path=${patchvless}&security=tls&encryption=none&type=ws&sni=bug.com#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=${patchvless}&security=none&encryption=none&host=bug.com&type=ws#${user}"
clear
echo -e "\e[$line═════[ACC XRAY VMESS & VLESS WEBSOCKET]══════\e[m"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "IP/Host        : $MYIP"
echo -e "Port Tls.      : ${tls}"
echo -e "Port None Tls  : ${none}"
echo -e "User ID        : ${uuid}"
echo -e "Security       : Auto"
echo -e "Network        : Websocket"
echo -e "\e[$line═════════════════════════════════════════════\e[m"
echo -e "Link Vmess Tls : ${vmesslink1}"
echo -e "\e[$line═════════════════════════════════════════════\e[m"
echo -e "Link Vless Tls : ${vlesslink1}"
echo -e "\e[$line═════════════════════════════════════════════\e[m"
echo -e "Link Vmess None TLS  : ${vmesslink2}"
echo -e "\e[$line═════════════════════════════════════════════\e[m"
echo -e "Link Vless None TLS  : ${vlesslink2}"
echo -e "\e[$line═════════════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"