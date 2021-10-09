#!/bin/bash
set -x
set -e
HOME=/root_tmp

cd ~
git clone  -b linux-5.10.y --single-branch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git 
cd linux
curl https://raw.githubusercontent.com/KusakabeSi/UML-Config/main/5.10.config  --output .config
make linux ARCH=um SUBARCH=x86_64 -j $(nproc)

cd ~
git clone https://github.com/KusakabeSi/EtherGuard-VPN
cd EtherGuard-VPN
make

cd ~
git clone https://gitlab.nic.cz/labs/bird.git
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

v=0.0.18
set +e
rm -r /tmp/*
rm -r /tmp/.*
exit 0
