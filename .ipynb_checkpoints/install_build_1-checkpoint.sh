#!/bin/bash
set -x
set -e
cd /buildroot
ls -al
cp -p lib/runit-docker.so /lib/runit-docker.so
cp -p root_tmp/linux/linux                            /usr/bin/linux-um
cp -p root_tmp/EtherGuard-VPN/etherguard-go           /usr/bin/etherguard-go
cp -p root_tmp/bird-lg-go/frontend/frontend           /usr/bin/bird-lg-frontend
cp -p root_tmp/bird-lg-go/proxy/proxy                 /usr/bin/bird-lg-proxy
cp -p sbin/bird                                       /usr/bin/bird
cp -p sbin/birdc                                      /usr/bin/birdc
cp -p sbin/birdcl                                     /usr/bin/birdcl
cp -p usr/bin/wg                                      /usr/bin/wg

rm -rf /tmp
mkdir -p /tmp
