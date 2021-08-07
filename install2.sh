#!/bin/bash
set -x
set -e
echo "Config for azure"
echo "root:Docker!" | chpasswd
mkdir /run/sshd
chmod 777 /tmp
HOME=/root_tmp
PERM_ROOT=$HOME/.rootfs
echo "link folder to azure writeable folder"
                                mv    /root /root_tmp                                    ; ln -s home/root                                    /root 
mkdir -p $PERM_ROOT/etc/sv    ; rm -r /etc/sv                                            ; ln -s ../home/root/.rootfs/etc/sv                  /etc/sv 
mkdir -p $PERM_ROOT/etc       ; mv    /etc/crontab        $PERM_ROOT/etc/crontab         ; ln -s ../home/root/.rootfs/etc/crontab             /etc/crontab 
mkdir -p $PERM_ROOT/etc       ; mv    /etc/tor            $PERM_ROOT/etc/tor             ; ln -s ../home/root/.rootfs/etc/tor                 /etc/tor 
mkdir -p $PERM_ROOT/var/www   ; mv    /var/www/html       $PERM_ROOT/var/www/html        ; ln -s ../../home/root/.rootfs/var/www/html         /var/www/html 
mkdir -p $PERM_ROOT/var/lib   ; mv    /var/lib/mysql      $PERM_ROOT/var/lib/mysql       ; ln -s ../../home/root/.rootfs/var/lib/mysql        /var/lib/mysql
mkdir -p $PERM_ROOT/var/lib   ; mv    /var/lib/postgresql $PERM_ROOT/var/lib/postgresql  ; ln -s ../../home/root/.rootfs/var/lib/postgresql   /var/lib/postgresql
mkdir -p $PERM_ROOT/var/lib   ; mv    /var/lib/mongodb    $PERM_ROOT/var/lib/mongodb     ; ln -s ../../home/root/.rootfs/var/lib/mongodb      /var/lib/mongodb 
                                                                                           ln -s ../home/root/.rootfs/etc/rc.local            /etc/rc.local
echo "eval \"\$(thefuck --alias)\"" >> ~/.bashrc
echo "eval \"\$(thefuck --alias)\"" >> ~/.zshrc
echo "thefuck --alias | source" >> /etc/fish/config.fish
rm -r $HOME/.config/fish
ln -s /etc/fish $HOME/.config/fish

#delete self
rm /tmp/install2.sh

set +e
rm -r /tmp/*
rm -r /tmp/.*
exit 0
