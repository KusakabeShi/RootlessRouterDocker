#!/bin/bash
set -x
set -e
mkdir /root_tmp
export HOME=/root_tmp
export DEBIAN_FRONTEND=noninteractive
. /etc/lsb-release
echo "Install & update"
sed -i 's|http://archive.|http://hk.archive.|g' /etc/apt/sources.list
apt-get -y update
apt-get -y install software-properties-common
add-apt-repository universe
add-apt-repository ppa:longsleep/golang-backports
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install apt-utils runit locales openssh-server autossh cron vim git sudo rsync nginx-extras
apt-get -y install mysql-client mysql-server unzip \
 php-fpm php-common php-mbstring php-xmlrpc php-soap  php-gd php-xml php-intl php-mysql php-cli php-zip php-curl \
 fish zsh tmux htop thefuck wget curl aria2 lsof tree ncdu \
 golang-go default-jre-headless python3-setuptools python3 python3-pip python3-dev g++ gcc \
 net-tools iputils-\* p7zip-full p7zip-rar mongodb shellcheck\
 autoconf bison build-essential gawk gdb git-core gnupg2 lftp libsqlite3-dev libssl-dev libtool \
 netcat netpipes nmap nnn parallel postgresql \
 qalc ranger rsyncrypto dnsutils \
 sl socat sqlite3 tig tor tor-geoipdb torsocks ttyrec vifm zlib1g-dev zlib1g-dev
curl https://rclone.org/install.sh | sudo bash
pip3       install --upgrade git+https://github.com/arthaud/python3-pwntools.git speedtest-cli tornado flask django jupyterlab jupyterhub
wget -qO- https://deb.nodesource.com/setup_current.x | bash
apt-get -y install nodejs
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ;  ~/.fzf/install
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
rm -rf /var/lib/apt/lists/* ; localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 ; locale-gen en_US.UTF-8
npm install -g configurable-http-proxy

exit 0
