#!/bin/bash
#Script for automated mac changing and spoofing.
green='\e[0;34m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'

menu1 () {
echo -n -e $yellow"[?] Want to change mac address? Y/n [?]\n"; tput sgr0
read answer
if test $answer == "Y"
	then
	echo -n -e "$white[*] Write your interface [*] "; tput sgr0
	read intrf
	sudo ifconfig $intrf down
	echo -n -ee "$white[*] Write your new mac (Ex. xx:xx:xx:xx:xx:xx) [*] "; tput sgr0
	read mac
	sleep 1
	sudo macchanger -m $mac $intrf
	sudo ifconfig $intrf up
	sudo service networking restart
	sudo service network-manager restart
	echo $lightgreen"[!] DONE [!]"
	sleep 3
	exit
elif test $answer == "N"
	then
	echo $blue"[!] Bye!! [!]"
	exit
fi
}

echo -n -e $yellow"[?] Want to reset your MAC Address? (Y/n) [?] "; tput sgr0
read reset
if test $reset == "Y"
	then
	echo -n -e $white"[*] Write your interface [*] "; tput sgr0
	read intrf1
	sudo ifconfig $intrf1 down
	sudo macchanger -p $intrf1
	sleep 2
	sudo ifconfig $intrf1 up
	sleep 2
	sudo service networking restart
	sudo service network-manager restart
	menu1
elif test $reset == "N"
	then
	menu1
fi
