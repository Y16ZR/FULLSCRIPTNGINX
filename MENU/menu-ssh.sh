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
green='\e[0;32m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
yellow='\e[0;33m'
clear
echo -e ""
echo -e "  ${blue}=•= SSH & OPENVPN =•=${NC}"
echo -e ""
echo -e "  $blue[${white}1${blue}] ${white}Create account ssh & openvpn$NC"
echo -e "  $blue[${white}2${blue}] ${white}Trial account ssh & openvpn$NC"
echo -e "  $blue[${white}3${blue}] ${white}Delete account ssh & openvpn$NC"
echo -e "  $blue[${white}4${blue}] ${white}Renew account ssh & openvpn$NC"
echo -e "  $blue[${white}5${blue}] ${white}Show user login account ssh & openvpn$NC"
echo -e "  $blue[${white}6${blue}] ${white}Show status account ssh & openvpn$NC"
echo -e "  $blue[${white}7${blue}] ${white}Delete user expired ssh & openvpn$NC"
echo -e "  $blue[${white}8${blue}] ${white}Set up autokill ssh$NC"
echo -e "  $blue[${white}9${blue}] ${white}Check users who do multi login ssh$NC"
echo -e "  $blue[${white}10${blue}] ${white}Show users list ssh & openvpn$NC"
echo -e "  $blue[${white}11${blue}] ${white}Lock users ssh & openvpn$NC"
echo -e "  $blue[${white}12${blue}] ${white}Unlock users ssh & openvpn$NC"
echo -e "  $blue[${white}13${blue}] ${white}Change password users ssh & openvpn$NC"
echo -e "  $blue[${white}x${blue}] ${red}Exit/Main menu$NC"
echo -e ""
echo -ne "  $(echo -e     ${white}Select from options  ${blue}[${NC}1-13 or x${blue}]${NC} :) " && read ssh
echo -e ""
case $ssh in
1)
add-ssh
;;
2)
trial
;;
3)
del-ssh
;;
4)
renew-ssh
;;
5)
check-ssh
;;
6)
member
;;
7)
delete
;;
8)
autokill
;;
9)
ceklim
;;
10)
user-list
;;
11)
user-lock
;;
12)
user-unlock
;;
13)
user-password
;;
X)
menu
;;
x)
menu
;;
*)
echo -e "${red}Please enter an correct number ${NC}"
sleep 1
menu-ssh
;;
esac
