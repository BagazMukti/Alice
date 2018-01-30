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
         [VERSION 1.2]    |/";
if [ ! $1 ]; then
	echo "
Usage:
  bash $0 <url> <wordlist>
  bash $0 <url> <wordlist> <proxy:port>
Example:
  bash $0 www.google.com wordlist/dir.lst
  bash $0 www.google.com wordlist/dir.lst 1.2.3.4:80"
else
	echo "[$(date +%H:%M:%S)] Alice starting...
[$(date +%H:%M:%S)] Target: $1
[$(date +%H:%M:%S)] Checking target..."
	ip=$(ping -q -c 1 -t 1 $1 | grep -m 1 PING | cut -d "(" -f2 | cut -d ")" -f1)
	if [ ! $ip ]; then
		echo "[$(date +%H:%M:%S)] Error occured! Exit..."
		exit
	fi
	echo "[$(date +%H:%M:%S)] Target IP: $ip
[$(date +%H:%M:%S)] Wordlist file: $2"	
	if [ $3 ]; then
		cp=$(curl https://bagazmukti.github.io/cp.txt -sx $3 --connect-timeout 10)
		if [ $cp ]; then
			proxy="$3"
		else
			proxy=null
			echo "[$(date +%H:%M:%S)] Proxy error..."
		fi
	else
		proxy=null
	fi
	ua=$(shuf -n 1 user-agents.txt)
	echo "[$(date +%H:%M:%S)] Proxy: $proxy
[$(date +%H:%M:%S)] User agent: $ua
[$(date +%H:%M:%S)] Starting bruteforce..."
	dirs=$(cat $2)
	for dir in $dirs; do
		if echo $1 | grep -q "http://"; then
			url="$1/$dir"
		else
			url="http://$1/$dir"
		fi
		if [ $proxy = "null" ]; then
			cek=$(curl -IsA "$ua" $url | head -n 1)
		else
			cek=$(curl -IsA "$ua" $url -x "$proxy" | head -n 1)
		fi
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
