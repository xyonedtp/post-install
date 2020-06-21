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
apt install -y rsh-client finger

