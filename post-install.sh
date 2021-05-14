#!/bin/bash

if (( $EUID != 0 )); then
	echo "Please run as root"
	exit
fi

echo "[*] Updating..."
apt update && apt upgrade -y

echo "[*] Installing standard tools..."
# Terminal
apt install -y terminator
# CRT 
apt install -y rsh-client ipcalc finger nbtscan-unixwiz
# ... need an old version of rsh-client
curl -O http://http.us.debian.org/debian/pool/main/n/netkit-rsh/rsh-client_0.17-17+b1_amd64.deb
dpkg -i rsh-client_0.17-17+b1_amd64.deb
rm rsh-client_0.17-17+b1_amd64.deb
# Others
apt install -y seclists

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
apt install -y python-pip
# EyeWitness
git clone https://github.com/ChrisTruncer/EyeWitness.git /opt/EyeWitness
/opt/EyeWitness/Python/setup/setup.sh
# TODO Docker

echo "[*] .zshrc Functions & Aliases..."
cp ~kali/.zshrc ~kali/.zshrc.orig
cat << EOT >> ~kali/.zshrc
# Functions & Aliases
alias stripcolours='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

addhost(){
	mkdir $1;
	cd $1
	echo -n $1 > host
}
EOT
# Do the same for root
cp ~/.zshrc ~/.zshrc.orig
cat << EOT >> ~/.zshrc
# Functions & Aliases
alias stripcolours='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

addhost(){
	mkdir $1;
	cd $1
	echo -n $1 > host
}
EOT
echo "[*] Done!"

