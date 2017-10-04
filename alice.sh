#!/bin/bash
# Files and Directories Bruteforce
# Codename: Alice
# Version: 1.1
# Author: Bagaz Mukti
# https://github.com/BagazMukti/Alice

echo "    _     _  _
   / \   | |(_)  ___  ___  _
  / _ \  | || | / __|/ _ \(_)
 / ___ \ | || || (__|  __/ _
/_/   \_\|_||_| \___|\___|( )
         [VERSION 1.1]    |/";
read -p "Site target: " url
read -p "Wordlist filename: " wl
echo -e "\n[$(date +%H:%M:%S)] Alice starting...
[$(date +%H:%M:%S)] Target: $url
[$(date +%H:%M:%S)] Checking target...";
ip=$(ping -q -c 1 -t 1 $url | grep -m 1 PING | cut -d "(" -f2 | cut -d ")" -f1)
if [ ! $ip ]; then
	echo "[$(date +%H:%M:%S)] Error occured! Exit..."
	exit
fi
echo "[$(date +%H:%M:%S)] Target IP: $ip
[$(date +%H:%M:%S)] Filename of wordlist: $wl"
ua=$(shuf -n 1 user-agents.txt)
echo "[$(date +%H:%M:%S)] User agent: $ua
[$(date +%H:%M:%S)] Starting bruteforce...";
dirs=$(cat wordlist/$wl)
for dir in $dirs; do
	url="$url/$dir"
	cek=$(curl -IsA "$ua" $url | head -n 1)
	if echo "$cek" | grep -q "404"; then
		echo -n
	else
		echo "[$(date +%H:%M:%S)] $url => Found"
	fi
done
echo "[$(date +%H:%M:%S)] Bruteforce done...
[$(date +%H:%M:%S)] Stopping alice..."
exit
