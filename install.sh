#!/bin/bash
set -x
export HOME=/tmp
export DEBIAN_FRONTEND=noninteractive
echo "Install & update"
apt-get -y update ; apt-get -y dist-upgrade
apt-get -y install software-properties-common
add-apt-repository universe
apt-get -y update ; apt-get -y dist-upgrade
apt-get -y install apt-utils runit locales openssh-server autossh cron vim git sudo rsync syslog-ng nginx apache2
apt-get -y install mysql-client mysql-server
apt-get -y install php7.2-fpm php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-soap 
apt-get -y php7.2-gd php7.2-xml php7.2-intl php7.2-mysql php7.2-cli php7.2-zip php7.2-curl
apt-get -y install fish zsh tmux htop thefuck wget curl aria2 lsof tree ncdu 
apt-get -y install golang default-jdk python-pip python-setuptools python3 python3-pip python3-dev g++ gcc lua50 perl 
pip3 install --upgrade git+https://github.com/arthaud/python3-pwntools.git speedtest-cli
apt-get -y install net-tools iputils-* p7zip-full p7zip-rar 
apt-get -y install ack atop autoconf bison build-essential byobu calcurse cloc dirmngr dstat dtach duplicity 
apt-get -y emacs gawk gdb git-core glances gnupg2 iftop ipcalc iptraf ledger lftp libsqlite3-dev libssl-dev libtool 
apt-get -y mc mtr multitail netcat nethogs netpipes nikto nmap nnn oysttyer parallel pgadmin3 polipo postgresql powertop 
apt-get -y pydf qalc qbittorrent-nox ranger remind rsstail rsyncrypto rtorrent screen searchandrescue siege silversearcher-ag 
apt-get -y sl slashem slurm socat sqlite3 tig tor tor-geoipdb torsocks tpp tsung ttyrec vifm wyrd yersinia zlib1g-dev zlib1g-dev
wget -qO- https://deb.nodesource.com/setup_12.x | bash
apt-get install -y nodejs
wget https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb -P /
dpkg -i /ripgrep_11.0.1_amd64.deb ; rm /ripgrep_11.0.1_amd64.deb
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /packages-microsoft-prod.deb
dpkg -i /packages-microsoft-prod.deb ; rm /packages-microsoft-prod.deb
apt-get -y install apt-transport-https ; apt-get update ; apt-get -y install dotnet-runtime-2.2
apt-get -y autoremove ; apt-get autoclean
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf ;  ~/.fzf/install
sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
rm -rf /var/lib/apt/lists/* ; localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 ; locale-gen en_US.UTF-8


echo "Config for azure"
echo "root:Docker!" | chpasswd
mkdir /run/sshd
chmod 777 /tmp


echo "link folder to azure writeable folder"
mkdir -p /home/root/.rootfs/etc/sv
cp -r /root          /home 
rm -r /root          ; ln -s home/root                      /root 
rm -r /etc/sv        ; ln -s ../home/root/.rootfs/etc/sv       /etc/sv 
rm    /etc/crontab   ; ln -s ../home/root/.rootfs/etc/crontab  /etc/crontab 
rm -r /var/www/html  ; ln -s ../../home/root/.rootfs/var/www/html /var/www/html 
mkdir -p ~/.rootfs/var/lib ; mv /var/lib/mysql ~/.rootfs/var/lib/mysql 
ln -s ../../home/root/.rootfs/var/lib/mysql /var/lib/mysql 
ln -s ../home/root/.rootfs/etc/rc.local /etc/rc.local 
echo "eval \"\$(thefuck --alias)\"" >> ~/.bashrc
echo "eval \"\$(thefuck --alias)\"" >> ~/.zshrc
echo "thefuck --alias | source" >> /etc/fish/config.fish 


cd /tmp
mv sshd_config /etc/ssh/
mv rcS         /etc/init.d/
mv locale      /etc/default/
chmod 755 /etc/init.d/rcS

#delete self
rm /tmp/install.sh

set +e
rm -r dotnet-installer
rm -r fish.root
rm -r hsperfdata_root
exit 0
