# syntax = docker/dockerfile:experimental
FROM --platform=$TARGETPLATFORM ubuntu
VOLUME ["/home"]

COPY   *.c /tmp/

COPY   install.sh /tmp/
RUN    bash /tmp/install.sh

COPY   install2.sh /tmp/
RUN    bash /tmp/install2.sh


RUN --mount=type=bind,source=move2docker,target=/tmp/move2docker rsync -a --no-owner --no-group --chown=root:root --keep-dirlinks /tmp/move2docker/* /;

ENV EDITOR vim \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

EXPOSE 80 2222 8080
ENTRYPOINT ["/sbin/runit-docker"]

