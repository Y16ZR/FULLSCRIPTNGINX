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

tls="$(cat ~/log-install.txt | grep -w "Vmess/Vless Grpc Tls" | cut -d: -f2|sed 's/ //g')"
NUMBER_OF_CLIENTS=$(grep -c -E "^#vmsgrpc " "/usr/local/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "SHOW USER XRAY VMESS & VLESS GRPC TLS"
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^#vmsgrpc " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
patchvmess=vmess-grpc
patchvless=vmess-grpc
user=$(grep -E "^#vmsgrpc " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
harini=$(grep -E "^#vmsgrpc " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#vmsgrpc " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
uuid=$(grep -E "^#vmsgrpc " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 5 | sed -n "${CLIENT_NUMBER}"p)
cat>/usr/local/etc/xray/$user-vmess-grpc.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "$tls",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "${patchvmess}",
      "type": "none",
      "tls": "tls"
      "sni": "bug.com"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmesslink="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-vmess-grpc.json)"

sed -i '/#vless-grpc$/a\#vlsgrpc '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=${patchvless}&sni=bug.com#${user}"

clear
echo ""
echo -e "\e[$line═════[ACC XRAY VMESS & VLESS GRPC TLS]══════\e[m"
echo -e "Remarks              : ${user}"
echo -e "Domain               : ${domain}"
echo -e "IP/Host              : $MYIP"
echo -e "Port Tls             : ${tls}"
echo -e "User ID              : ${uuid}"
echo -e "ServiceName Vmess    : ${patchvmess}"
echo -e "ServiceName Vless    : ${patchvmess}"
echo -e "Network              : Grpc"
echo -e "\e[$line════════════════════════════════════════════\e[m"
echo -e "Link Vmess Grpc Tls : ${vmesslink}"
echo -e "\e[$line════════════════════════════════════════════\e[m"
echo -e "Link Vless Grpc Tls : ${vlesslink}"
echo -e "\e[$line════════════════════════════════════════════\e[m"
echo -e "Created   : $harini"
echo -e "Expired   : $exp"
echo -e "Script By $creditt"