#!/bin/bash

bitcoinVersion="0.20.1"

cd ~
sudo apt update
sudo apt install tor
sudo unattended-upgrade
sudo rm -Rf bitcoincoredownload
mkdir bitcoincoredownload
cd bitcoincoredownload

wget https://bitcoincore.org/bin/bitcoin-core-${bitcoinVersion}/bitcoin-${bitcoinVersion}-x86_64-linux-gnu.tar.gz
wget https://bitcoin.org/bin/bitcoin-core-${bitcoinVersion}/SHA256SUMS.asc
tar xvzf bitcoin-${bitcoinVersion}-x86_64-linux-gnu.tar.gz

sha256sum --ignore-missing --check SHA256SUMS.asc
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964
gpg --verify SHA256SUMS.asc 

sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-${bitcoinVersion}/bin/*

mkdir ~/.bitcoin
# onion nodes copied from https://github.com/rootzoll/raspiblitz/
echo -e "proxy=127.0.0.1:9050\nserver=1\nlisten=1\nbind=127.0.0.1\nonlynet=onion\ndnsseed=0\ndns=0\nblockfilterindex=1\naddnode=fno4aakpl6sg6y47.onion\naddnode=toguvy5upyuctudx.onion\naddnode=ndndword5lpb7eex.onion\naddnode=6m2iqgnqjxh7ulyk.onion\naddnode=5tuxetn7tar3q5kp.onion\naddnode=juo4oneckybinerq.onion" > ~/.bitcoin/bitcoin.conf
