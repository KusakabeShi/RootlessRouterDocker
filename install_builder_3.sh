#!/bin/bash
set -x
set -e
HOME=/root_tmp

cd ~
git clone --depth 1  https://github.com/KusakabeSi/slirpnetstack slirpnetstack
cd slirpnetstack
go mod vendor
make
ls bin

cd ~
git clone https://github.com/KusakabeSi/EtherGuard-VPN
cd EtherGuard-VPN
make

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

cd ~
git clone https://github.com/KusakabeSi/whois42d
cd whois42d
go mod init github.com/Mic92/whois42d
go mod tidy
go build -o whois42d

v=202201222337
set +e
rm -r /tmp/*
rm -r /tmp/.*
exit 0
