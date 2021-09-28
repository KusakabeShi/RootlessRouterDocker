#!/bin/bash
set -x
set -e
cd /buildroot
ls -al
cp -p lib/runit-docker.so /lib/runit-docker.so
cp -p root_tmp/wireguard-go-vpp/wireguard-go-vpp      /usr/bin/wireguard-go-vpp
cp -p root_tmp/EtherGuard-VPN/etherguard-go-vpp       /usr/bin/etherguard-go-vpp
cp -p root_tmp/bird-lg-go/frontend/frontend           /usr/bin/bird-lg-frontend
cp -p root_tmp/bird-lg-go/proxy/proxy                 /usr/bin/bird-lg-proxy
cp -p sbin/bird                                       /usr/bin/bird
cp -p sbin/birdc                                      /usr/bin/birdc
cp -p sbin/birdcl                                     /usr/bin/birdcl
cp -p usr/bin/wg                                      /usr/bin/wg
cd /buildroot/root_tmp/vpp/build-root
dpkg -i libvppinfra_*_amd64.deb
dpkg -i vpp_*_amd64.deb             || apt-get -f install -y
dpkg -i vpp-plugin-core_*_amd64.deb || apt-get -f install -y
dpkg -i vpp-plugin-core_*_amd64.deb || apt-get -f install -y
dpkg -i python3-vpp-api_*_amd64.deb || apt-get -f install -y
rm -rf /tmp
mkdir -p /tmp
