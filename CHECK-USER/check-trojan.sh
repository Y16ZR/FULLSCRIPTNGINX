#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/config.json | grep '^#trx' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\\E[0;41;104m   XRAY Trojan GRPC User Login     \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrgrpc.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp | grep xray | awk '{print $4}' | cut -d: -f 1,2 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w $akun | awk '{print $4}' | cut -d: -f 1,2 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptrgrpc.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrgrpc.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrgrpc.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/iptrgrpc.txt | nl)
echo "User : $akun";
echo "$jum2";
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
fi
rm -rf /tmp/iptrgrpc.txt
rm -rf /tmp/other.txt
done
echo ""