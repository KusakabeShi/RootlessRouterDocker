# Docker-image-for-azure-appservice-container
This is a dockerfile that create an docker image for azure app service. 

It contain crontab and service conrol and runit. similar to https://github.com/phusion/baseimage-docker , but this is Ubuntu 18.04.

And other stuff. Such as ssh(https://docs.microsoft.com/en-us/azure/app-service/containers/app-service-linux-ssh-support).

## How to build it

Prepare build kit
```
# make your computer able to rum arm64 binary
docker run --rm --privileged docker/binfmt:820fdd95a9972a5308930a2bdfb8573dd4447ad3
# enable expremental feature
export DOCKER_CLI_EXPERIMENTAL=enabled
export DOCKER_BUILDKIT=1
docker buildx create --name mybuilder_az --driver docker-container
docker buildx use mybuilder_az
```

Build
```bash
#In this case, we use "ubuntu-test" as image name. you can use wathever you want.
docker buildx build  --platform linux/arm64,linux/amd64 -t whojk/ubuntu-azure-apps . --output="type=docker"
docker push whojk/ubuntu-azure-apps

#Test in localhost
docker run -d ubuntu-test
ssh root@172.16.0.2 -p 2222
```

## How to use it:
Upload to the docker hub, and deploy it to azure app service
![Azure deploy example](https://i.imgur.com/uox9lwO.png)

## Boot order
1. /etc/init.d/rcS
2. /etc/rc.local
3. all services stored at /etc/sv

## Environment Variables

1. `APT_UPDATE` : `0/1`, run `apt update` at startup
1. `APT_UPGRADE` : `0/1`, run `apt upgrade` at startup
1. `UPTIME_LOG` : `0/1`, enable uptime log at `/root/.log/uptime.log`
    1. `TZ` : Time zone
1. `AUTOSSH`:  `0/1`, enable autossh to connect to other external servers
    1. `SSH_KEY`: printf formatted id_rsa openssh private key file, use to connect to your server
    1. `SSH_KNOW_HOSTS` : printf formatted known_hosts file, use to connect to your server without asking unknow hosts
    1. `SSH_AUTHED_KEYS` : printf formatted authorized_keys file. Use to allow remote incoming connection(password is disabled)
    1. `SSH_USER` : username to connect to ssh server
    1. `SSH_CONN` : domain/ip to connect to ssh server 
    1. `SSH_CONN_PORT` : port to connect to ssh server
    1. `RSSH_PROXY_MONITOR_PORT` : monitoring port of autossh
    1. `RSSH_PROXY_PORT` : ssh will exposed on this port at remote server
1. `INIT_STARTUP`: run `/etc/init.d/{program} start` at startup.
    1. Format: split service name with `:`
    1. Supported value:
        1. `mongodb`
        1. `mysql`
        1. `php7.4-fpm`
        1. `postgresql`
        1. `tor`
1. Other Variables:
    1. https://docs.microsoft.com/en-us/azure/app-service/faq-app-service-linux#custom-containers
    
You can checkout this example environment variables file: [env_file_example](env_file_example)