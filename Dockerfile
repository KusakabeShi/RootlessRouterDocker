FROM ubuntu
VOLUME ["/home"]

COPY install.sh  /tmp
COPY sshd_config /tmp
COPY rcS         /tmp
COPY locale      /tmp
RUN  chmod 755 /tmp/install.sh ; /tmp/install.sh
COPY sshd_nopwd_config /etc/ssh

ENV EDITOR vim
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8


EXPOSE 80 2222 8080

ENTRYPOINT ["/sbin/runit"]

