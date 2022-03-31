#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo ""
echo -e "Want To Change Domain ?"
echo -e ""
echo -e " [1] YES"
echo -e " [2] NO"
echo -e ""
read -rp "Select an option [1-2]: " MENU_OPTION
case "${MENU_OPTION}" in
	1)
		make install
		break
		;;
	2)
		exit 0
		;;
	   *)
	echo -e "${Error}Please enter the correct number [1-2] "
    echo ""
    read -n1 -r -p "Press any key to continue..."
    menu
	;;
	esac
clear
echo -e "Please Insert  Your Domain"
read -p "Hostname / Domain: " host
rm -f /var/lib/crot-script/ipvps.conf
rm -f /var/lib/premium-script/ipvps.conf
rm -f /etc/v2ray/domain
clear
mkdir /etc/v2ray
mkdir /var/lib/premium-script;
mkdir /var/lib/crot-script;
clear
echo -e "Please Insert Your Domain Again"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/crot-script/ipvps.conf
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" >> /etc/v2ray/domain
clear
echo -e "Renew V2ray Cert Started . . . ."
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/v2ray/domain)
systemctl stop xray-mini@vless-direct
systemctl stop xray-mini@vless-splice
systemctl disable xray-mini@vless-direct
systemctl disable xray-mini@vless-splice
systemctl stop v2ray
systemctl stop v2ray@none
systemctl stop v2ray@vless
systemctl stop v2ray@vnone
systemctl stop trojan
cd /root/
wget -O acme.sh https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh
bash acme.sh --install
rm acme.sh
cd .acme.sh
bash acme.sh --register-account -m vinstechmyproject@gmail.com
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
systemctl enable xray-mini@vless-direct
systemctl enable xray-mini@vless-splice
systemctl start xray-mini@vless-direct
systemctl start xray-mini@vless-splice
systemctl restart xray-mini@vless-direct
systemctl restart xray-mini@vless-splice
systemctl start v2ray
systemctl start v2ray@none
systemctl start v2ray@vless
systemctl start v2ray@vnone
systemctl start trojan
echo Done
sleep 0.5
clear 
neofetch