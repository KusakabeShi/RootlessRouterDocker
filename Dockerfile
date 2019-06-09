FROM ubuntu
VOLUME ["/home"]

#Install & update
ARG HOME=/tmp
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y dist-upgrade && \
    apt-get -y install apt-utils runit locales openssh-server cron vim git sudo rsync syslog-ng nginx && \
	apt-get -y install mysql-client mysql-server && \
	apt-get -y install php7.2-fpm php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-intl php7.2-mysql php7.2-cli php7.2-zip php7.2-curl && \
	apt-get -y install fish zsh tmux htop thefuck wget curl aria2 lsof && \
	apt-get -y install golang default-jdk python-pip python-setuptools python3-pip g++ gcc lua50 perl && \
	apt-get -y install net-tools iputils-* p7zip-full p7zip-rar kmod && \
    apt-get -y install socat netcat ack silversearcher-ag mtr pydf mc lftp nnn nikto yersinia firefox chromium-browser tor tor-geoipdb torsocks polipo qalc ipcalc tig cloc powertop cowsay sl newsbeuter rsstail vifm ranger calcurse remind wyrd oysttyer rtorrent nethack-console slashem taskwarrior duplicity rsyncrypto ledger parallel siege tsung tpp iftop iptraf nethogs multitail netpipes screen dtach byobu emacs ttyrec slurm glances atop searchandrescue dstat && apt-get autoremove -y && \
    apt-get autoremove -y && apt-get autoclean && \
    wget https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb -P / && dpkg -i /ripgrep_11.0.1_amd64.deb && rm /ripgrep_11.0.1_amd64.deb && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &&  ~/.fzf/install && \
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
    rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && locale-gen en_US.UTF-8


#Config for azure
RUN echo "root:Docker!" | chpasswd && \
    mkdir /run/sshd && \
    chmod 777 /tmp

#link usual folder to azure writeable folder
RUN mkdir -p /home/root/.rootfs/etc/sv && \
    cp -r /root          /home && \
    rm -r /root          && ln -s home/root                      /root && \
    rm -r /etc/sv        && ln -s ../home/root/.rootfs/etc/sv       /etc/sv && \
    rm    /etc/crontab   && ln -s ../home/root/.rootfs/etc/crontab  /etc/crontab && \
    ln -s ../home/root/.rootfs/etc/rc.local /etc/rc.local && \
    echo "eval \"\$(thefuck --alias)\"" >> ~/.bashrc && echo "eval \"\$(thefuck --alias)\"" >> ~/.zshrc && echo "thefuck --alias | source" >> /etc/fish/config.fish && \
	chsh -s /bin/zsh root



COPY sshd_config /etc/ssh/
COPY rcS         /etc/init.d/
COPY locale      /etc/default/locale
RUN  chmod 755 /etc/init.d/rcS

ENV EDITOR vim
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


EXPOSE 80 2222

ENTRYPOINT ["/sbin/runit"]

