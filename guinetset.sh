#!/bin/bash




DNS_INIT()
{
WORKPATH="/etc/resolvconf/resolv.conf.d/base"
grep "nameserver" $WORKPATH  >>/dev/null
 nameserverflag=$?
if [ $nameserverflag -ne 0 ]
then
echo "nameserver 221.6.4.66">>$WORKPATH
fi
}

#初始化 ip地址
NET_INIT()
{
WORKPATH="/etc/network/interfaces"
 grep "em1" $WORKPATH  >>/dev/null
 em1flag=$?
if [ $em1flag -ne 0 ] 
then
 echo "auto em1">>$WORKPATH
 echo "iface em1 inet static">>$WORKPATH
 echo "address 122.192.0.174">>$WORKPATH
 echo "netmask 255.255.255.248">>$WORKPATH
 echo "gateway 122.192.0.169">>$WORKPATH
 DNS_INIT
 whiptail  --title "Note" --yesno "Net init  successful ,but it needs reboot,reboot now?" 20 30   
 RETVAL=$?
 [ $RETVAL -eq 0 ] && reboot|| MENU

else
 RESET
 em1flag=$?
[  $? ] && whiptail  --title "Note" --yesno "Net settng successful ,but it needs reboot,reboot now?" 20 30   
RETVAL=$?
[ $RETVAL -eq 0 ] && reboot||MENU
fi
}

RESET()
{
WORKPATH="/etc/network/interfaces"
ip=`grep -n "address" $WORKPATH| gawk {'print $2'}`
gateway=`grep -n "gateway" $WORKPATH| gawk {'print $2'}`
netmask=`grep -n "netmask" $WORKPATH| gawk {'print $2'}`
sed -i "/address/s/$ip/122.192.0.174/" $WORKPATH
sed -i "/gateway/s/$gateway/122.192.0.169/" $WORKPATH
sed -i "/netmask/s/$netmask/255.255.255.248/" $WORKPATH
WORKPATH="/etc/resolvconf/resolv.conf.d/base"
DNS=`grep -n "nameserver" $WORKPATH| gawk {'print $2'}`
sed -i "/nameserver/s/$DNS/221.6.4.66/" $WORKPATH
}

NET_SET()
{
WORKPATH="/etc/network/interfaces"

_ip=$(whiptail --title "ip set" --inputbox "Input ip address?" 10 60 0.0.0.0 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
ip=`grep -n "address" $WORKPATH| gawk {'print $2'}`
sed -i "/address/s/$ip/$_ip/" $WORKPATH
else
    MENU
fi

_netmask=$(whiptail --title "netmask set" --inputbox "Input netmask?" 10 60 255.255.255.0 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
netmask=`grep -n "netmask" $WORKPATH| gawk {'print $2'}`
sed -i "/netmask/s/$netmask/$_netmask/" $WORKPATH
else
    MENU
fi

_gateway=$(whiptail --title "gateway set" --inputbox "Input gateway?" 10 60 0.0.0.0 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
gateway=`grep -n "gateway" $WORKPATH| gawk {'print $2'}`
sed -i "/gateway/s/$gateway/$_gateway/" $WORKPATH
else
    MENU
fi

WORKPATH="/etc/resolvconf/resolv.conf.d/base"
_dns=$(whiptail --title "dns set" --inputbox "Input dns?" 10 60 8.8.8.8 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
DNS=`grep -n "nameserver" $WORKPATH| gawk {'print $2'}`
sed -i "/nameserver/s/$DNS/$_dns/" $WORKPATH

whiptail  --title "Note" --yesno "Net settng successful ,but it needs reboot,reboot now?" 20 30  
RETVAL=$?  
[ $RETVAL -eq 0 ] && reboot|| MENU 
else
    MENU
fi



}

DISPLAY()
{
TMPFILE=$(mktemp /tmp/tmp.XXXXXXXXXX)
WORKPATH="/etc/network/interfaces"
grep address $WORKPATH >>$TMPFILE
grep netmask $WORKPATH >>$TMPFILE
grep gateway $WORKPATH >>$TMPFILE
WORKPATH="/etc/resolvconf/resolv.conf.d/base"
grep nameserver $WORKPATH | sed 's/nameserver/dns/'>>$TMPFILE
whiptail --title "Configure" --textbox $TMPFILE 10 60
MENU
}

if [ $UID -ne 0 ]
then
   whiptail --title "Waring" --msgbox "Required root privileges!" 15 30
   clear
   exit

fi

MENU()
{
OPTION=$(whiptail --title "NetWork COnfigure" --menu "Choose your option" 15 60 4 \
"1" "Net init" \
"2" "Net set" \
"3" "Display configure" \
"0" "exit"  \
3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    case $OPTION in
1)
	NET_INIT
;;

2)
        NET_SET
;;
3)
        DISPLAY
;;
0)
	clear
;;
*)
        exit
	clear
;;

esac
else
    exit
    clear
fi
}

MENU
