#!/bin/bash

## 1) Add the following to '/etc/pf.conf'
#       table <facebook> persist file "/etc/pf.tables/facebook.conf"
#       block return in quick from <facebook>
#       block return out quick to <facebook>

## 2) Create the directory '/etc/pf.tables'
## 3) Run this script..

FACEBOOK_AS_NUMBER="AS32934"

curl -s https://ipinfo.io/${FACEBOOK_AS_NUMBER} \
    | grep "${FACEBOOK_AS_NUMBER}/" \
    | perl -npe 's/.*'${FACEBOOK_AS_NUMBER}'\/(.*?)\".*/$1/g' \
    | sudo tee /etc/pf.tables/facebook.conf

pfctl -vnf /etc/pf.conf

echo -e "\nContinue or [Ctrl-C] to exit.\n"
read
sudo pfctl -f /etc/pf.conf

echo -e "\nShow table stats or [Ctrl-C] to exit.\n"
read
sudo pfctl -vvsT

echo -e "\nShow table contents or [Ctrl-C] to exit.\n"
read
sudo pfctl -t facebook -Ts
