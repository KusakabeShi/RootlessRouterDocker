#!/bin/bash
set -x
set -e
export HOME=/root_tmp
export DEBIAN_FRONTEND=noninteractive
function get_cpu_architecture()
{
    local cpuarch=$(uname -m)
    case $cpuarch in
         x86_64)
              echo "amd64";
              ;;
         aarch64)
              echo "arm64";
              ;;
         *)
              echo "Not supported cpu architecture: ${cpuarch}"  >&2
              exit 1
              ;;
    esac
}
cpu_arch=$(get_cpu_architecture)
. /etc/lsb-release
echo "Install & update"
echo "deb [trusted=yes] https://packagecloud.io/fdio/release/ubuntu focal main" > /etc/apt/sources.list.d/99fd.io.list
curl -L https://packagecloud.io/fdio/release/gpgkey | apt-key add -
echo "deb [trusted=yes] https://packagecloud.io/fdio/master/ubuntu focal main" > /etc/apt/sources.list.d/m.99fd.io.list
curl -L https://packagecloud.io/fdio/master/gpgkey | apt-key add -
apt-get -y update
apt-get -y install  vpp vpp-plugin-core python3-vpp-api vpp-dbg libmemif

exit 0
