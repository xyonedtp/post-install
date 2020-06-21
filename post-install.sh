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
apt install -y rsh-client finger nbtscan-unixwiz

echo "[*] Config Changes..."
# Set default terminal
#TODO Find out how to do this one!

echo "[*] Done!"

