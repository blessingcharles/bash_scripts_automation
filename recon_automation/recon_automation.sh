#!/bin/bash



echo -e "\n\n
    --------- |     | 0000000    /\    /\     0000   0000000000000000000000000000000000000000000000
        |     |_____| 0  o  0   /  \  /  \   0    0  0                       0000000     0000      00000000
        |     |     | 0  o  0  /    \/    \  000000  0000000                 0          0    0        0
        |     |     | 0000000 /            \ 0    0         0       THE      0          000000        0
        |                    /              \               0                0000000    0    0        0
        | 000000000000000000000000000000000000000000000000000
        |                                   
                                                        --- THE HOAX \n\n"



 
printf "#######  Required tools: ----> nmap , gobuster , dirb ##########"



if  [ $# -ne 1 ] ; then 
	echo -e "\n\n<USAGE> ./recon_automation.sh <ip/domain> \n eg:  ip = 10.10.10.44 or domain = google.com\n"
	exit 1
fi

if [ ! -d "RESULTS" ] ; then
	mkdir RESULTS
fi


echo -e "\n\n############   MAKING DIRECTORY BRUTEFORCING ---->stored in RESULTS/dirbuster_results     ################"

domain="http://${1}/"

dirb $domain -w /usr/share/wordlists/dirb/common.txt > RESULTS/dirbuster_results &

echo -e "\nscanning the host -----> $1"

ip=`ping $1 -c1 | head -1 | grep -Eo '[0-9.]{4,}' | sort -u`


echo -e "\n##############    MAKING NMAP SCANNING ---->stored in RESULTS/nmap_results    #################\n"
echo -e "\n<<<<<<<<<<<<<<<< WAIT FOR FEW MOMENTS >>>>>>>>>>>>>>>>\n"

nmap -A -sV $ip > RESULTS/nmap_results &

wait

echo -e "\n\t\t\t############# Subdomain Enumeration  #################"

gobuster dns -d $1 -w subdomains.txt -o RESULTS/subdomains.txt &


echo -e "\n\nfinished enumerating the host"















