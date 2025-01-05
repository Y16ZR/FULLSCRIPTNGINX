#!/bin/bash
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

#Colour
white='\e[0;37m'
green='${blue}'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
NC='\e[0m'
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
echo ""
echo ""
tls="$(cat ~/log-install.txt | grep -w "Vmess/Vless Grpc Tls" | cut -d: -f2|sed 's/ //g')"

echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
echo -e   "  \e[$back_text      \e[0;30m[\e[$box CREATE USER XRAY VMESS & VLESS GRPC TLS \e[0;30m ]\e[0m\e[$back_text     \e[m"
echo -e   "  \e[$line═══════════════════════════════════════════════════════\e[m"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "   Username: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
patchvmess=vmess-grpc
patchvless=vmess-grpc
uuid=$(cat /proc/sys/kernel/random/uuid)
choose_bug () {
echo -e "   .-----------------------------------."
echo -e "   |       ${blue}Choose Your Trick VPN       \e[0m|"
echo -e "   '-----------------------------------'"
echo -e "     ${blue}1)\e[0m default SNI/Bug location"
echo -e "     ${blue}2)\e[0m reverse SNI/Bug as address"
echo -e "   ------------------------------------"
read -p "   Please select numbers 1-2: " trick
if [[ $trick == "1" ]]; then
tri=DEFAULT
elif [[ $trick == "2" ]]; then
tri=DEFAULT2
elif [[ $trick == "" ]]; then
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
fi
}
choose_bug
if [[ $tri == "DEFAULT" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Bug SNI/Host (Example : m.facebook.com) : " sni
read -p "   Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=$address
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
elif [[ $tri == "DEFAULT2" ]]; then
echo ""
read -p "   Bug As Address (Example: www.google.com) : " address
read -p "   Expired (days) : " masaaktif
bug_addr=${address}
bug_addr2=bug.com
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
else
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
choose_bug
fi
#BUG SNI
bug_sni=bug.com
bug_sni2=${sni}
if [[ $sni == "" ]]; then
stn=${bug_sni}
else
stn=$bug_sni2
fi
#CONFIG
if [[ $tri == "DEFAULT" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#vmess-grpc$/a\#vmsgrpc '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
echo -e ""
cat>/usr/local/etc/xray/$user-vmess-grpc.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}${domain}",
      "port": "$tls",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "${patchvmess}",
      "type": "none",
      "tls": "tls"
      "sni": "$stn"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmesslink="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-vmess-grpc.json)"

sed -i '/#vless-grpc$/a\#vlsgrpc '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink="vless://${uuid}@${sts}${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=${patchvless}&sni=${stn}#${user}"

systemctl restart xray
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

elif [[ $tri == "DEFAULT2" ]]; then
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
harini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#xray-vmess-tls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#xray-vmess-nontls$/a\#vms '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/none.json
cat>/usr/local/etc/xray/$user-tls.json<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${sts}",
      "port": "$tls",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "${patchvmess}",
      "type": "none",
      "tls": "tls"
      "sni": "${domain}"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmesslink="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-vmess-grpc.json)"

sed -i '/#vless-grpc$/a\#vlsgrpc '"$user $exp $harini $uuid"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
vlesslink="vless://${uuid}@${sts}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=${patchvless}&sni=${domain}#${user}"
systemctl restart xray
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
else
echo -e "${red}ERROR ${NC}"
sleep 1
fi
