#!/bin/bash

if (( $EUID != 0 )); then
	echo "Please run as root"
	exit
fi

echo "[*] Updating..."
apt update && apt upgrade -y

echo "[*] Installing standard tools..."
# Terminal
apt install -y tilix
# CRT 
apt install -y rsh-client ipcalc finger nbtscan-unixwiz
# ... need an old version of rsh-client
curl -O http://http.us.debian.org/debian/pool/main/n/netkit-rsh/rsh-client_0.17-17+b1_amd64.deb
dpkg -i rsh-client_0.17-17+b1_amd64.deb
rm rsh-client_0.17-17+b1_amd64.deb

echo "[*] Config Changes..."
# Set default terminal
#TODO Find out how to do this one!
# Remove the default SSH keys
cd /etc/ssh
rm ssh_host_*
dpkg-reconfigure openssh-server
/etc/init.d/ssh restart
cd ~

echo "[*] Tools..."
mkdir tools


echo "[*] Done!"

