#!/bin/bash
# Files and Directories Bruteforce
# Codename: Alice
# Author: Bagaz Mukti
# https://github.com/BagazMukti/Alice
echo "    _     _  _
   / \   | |(_)  ___  ___  _
  / _ \  | || | / __|/ _ \(_)
 / ___ \ | || || (__|  __/ _
/_/   \_\|_||_| \___|\___|( )
         [VERSION 1.0]    |/";
if [ ! $1 ]; then
	echo "Usage: bash $0 <url> <wordlist>
Example: bash $0 www.google.com word.lst";
else
	echo "[$(date +%H:%M:%S)] Alice starting...
[$(date +%H:%M:%S)] Target: $1
[$(date +%H:%M:%S)] Checking target...";
	ip=$(ping -q -c 1 -t 1 $1 | grep -m 1 PING | cut -d "(" -f2 | cut -d ")" -f1)
	if [ ! $ip ]; then
		echo "[$(date +%H:%M:%S)] Error occured! Exit..."
		exit
	fi
	echo "[$(date +%H:%M:%S)] Target IP: $ip
[$(date +%H:%M:%S)] Wordlist file: $2
[$(date +%H:%M:%S)] Starting bruteforce...";
	dirs=$(cat $2)
	for dir in $dirs; do
		url="$1/$dir"
		cek=$(curl --head --silent $url | head -n 1)
		if echo "$cek" | grep -q "404"; then
			echo -n
		else
			echo "[$(date +%H:%M:%S)] $url => Found"
		fi
	done
	echo "[$(date +%H:%M:%S)] Bruteforce done...
[$(date +%H:%M:%S)] Stopping alice..."
	exit
fi