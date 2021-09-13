#!/bin/bash

bitcoinVersion="22.0"

cd ~
sudo apt update
sudo apt install tor wget -y
sudo dist-upgrade -y
sudo rm -Rf bitcoincoredownload
mkdir bitcoincoredownload
cd bitcoincoredownload

torify wget https://bitcoincore.org/bin/bitcoin-core-${bitcoinVersion}/bitcoin-${bitcoinVersion}-x86_64-linux-gnu.tar.gz
torify wget https://bitcoincore.org/bin/bitcoin-core-${bitcoinVersion}/SHA256SUMS.asc
tar xvzf bitcoin-${bitcoinVersion}-x86_64-linux-gnu.tar.gz

sha256sum --ignore-missing --check SHA256SUMS.asc
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964
gpg --verify SHA256SUMS.asc 

sudo install -m 0755 -o root -g root -t /usr/local/bin bitcoin-${bitcoinVersion}/bin/*

mkdir ~/.bitcoin
# onion nodes copied from https://github.com/rootzoll/raspiblitz/
echo -e "proxy=127.0.0.1:9050\nserver=1\nlisten=1\nonlynet=onion\ndnsseed=0\ndns=0\nblockfilterindex=1\n" > ~/.bitcoin/bitcoin.conf
echo "main.bind=127.0.0.1" >> ~/.bitcoin/bitcoin.conf
echo "main.addnode=ira7kqcbff52wofoong2dieh2xlvmw4e7ya3znsqn7wivn6armetvrqd.onion" >> ~/.bitcoin/bitcoin.conf
echo "main.addnode=xlpi353v7ia5b73msynr7tmddgxoco7n2r2bljt5txpv6bpzzphkreyd.onion" >> ~/.bitcoin/bitcoin.conf
echo "main.addnode=ccjrb6va3j6re4lg2lerlt6wyvlb4tod7qbe7rwiouuapb7etvterxyd.onion" >> ~/.bitcoin/bitcoin.conf
echo "main.addnode=s7m4mnd6bokujhywsocxibispktruormushdroeaeqeb3imvztfs3vid.onion" >> ~/.bitcoin/bitcoin.conf
echo "main.addnode=ldvhlpsrvspquqnl3gutz7grfu5lb3m2dgnezpl3tlkxgpoiw2g5mzid.onion" >> ~/.bitcoin/bitcoin.conf
echo "main.addnode=gliovxxzyy2rkwaoz25khf6oa64c3csqzjn3t6dodsjuf34w6a6ktsyd.onion" >> ~/.bitcoin/bitcoin.conf
