#!/bin/bash
set -x
set -e
HOME=/root_tmp

cd ~
git clone https://github.com/KusakabeSi/vpp
cd vpp
./extras/vagrant/build.sh
make

cd ~
git clone https://github.com/KusakabeSi/wireguard-go-vpp
cd wireguard-go-vpp
make

cd ~
git clone https://github.com/KusakabeSi/EtherGuard-VPN
cd EtherGuard-VPN
make vpp

cd ~
git clone https://github.com/KusakabeSi/BIRD-vpp
cd BIRD-vpp
autoreconf
./configure --prefix=
make
make install

cd ~
git clone https://github.com/KusakabeSi/bird-lg-go
cd bird-lg-go
cd frontend
go build -ldflags "-w -s" -o frontend
chmod 755 frontend
cd ..
# Build proxy binary
cd proxy
go build -ldflags "-w -s" -o proxy
chmod 755 proxy
cd ..

v=0.0.16
set +e
rm -r /tmp/*
rm -r /tmp/.*
exit 0
