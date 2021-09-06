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

Build in local
```bash
docker buildx build  --platform linux/amd64 -t whojk/ubuntu-azure-apps . --output="type=docker"

#Test in localhost
docker run -it --rm --env-file=env_file_example --name=az whojk/ubuntu-azure-apps
docker exec -it az bash
```

Build and push
```bash
docker buildx build  --platform linux/arm64,linux/amd64 -t whojk/ubuntu-azure-apps . --push
```

## How to use it:
Upload to the docker hub, and deploy it to azure app service
![Azure deploy example](https://i.imgur.com/uox9lwO.png)

## Boot order
1. /etc/init.d/rcS
2. /etc/rc.local
3. all services stored at /etc/service

## Environment Variables

1. `APT_UPDATE` : `0/1`, run `apt update` at startup
1. `APT_UPGRADE` : `0/1`, run `apt upgrade` at startup
1. `UPTIME_LOG` : `0/1`, enable uptime log at `/root/.log/uptime.log`
    1. `TZ` : Time zone
1. `COMMAND_SSH`: `0/1`: ssh server for receive external command
    1. `AUTOSSH`:  `0/1`, use autossh to expose ssh port on remote server to receive external command
        1. `SSH_KEY`: printf formatted id_rsa openssh private key file, use to connect to your server
        1. `SSH_KNOW_HOSTS` : printf formatted known_hosts file, use to connect to your server without asking unknow hosts
        1. `SSH_AUTHED_KEYS` : printf formatted authorized_keys file. Use to allow remote incoming connection(password is disabled)
        1. `SSH_USER` : username to connect to ssh server
        1. `SSH_CONN` : domain/ip to connect to ssh server 
        1. `SSH_CONN_PORT` : port to connect to ssh server
        1. `RSSH_REMOTE_MONITOR_PORT` : monitoring port of autossh
        1. `RSSH_REMOTE_PORT` : ssh will exposed on this port on the remote server
    1. `FRPC`:  `0/1`, use frp client to expose ssh port on remote server to receive external command
        1. `FRPC_CONN`: frp server domain
        1. `FRPC_CONN_PORT`: frp server port
        1. `FRPC_USER`: frp user
        1. `FRPC_TOKEN`: frp token
        1. `FRPC_PROTO`: frp protocol. tcp/kcp/websocket
        1. `FRPC_REMOTE_PORT`: ssh will exposed on this port on the remote server
1. `CLOUDFLARED`: `0/1`, enable cloudflared
    1. `CLOUDFLARED_CERT`: printf formatted cert.pem
    1. `CLOUDFLARED_LOCAL_PORT`: cloudflared proxied internal port
    1. `CLOUDFLARED_DOMAIN`: cloudflared
    1. `JUPYTER`: `0/1`, enable internal jupyter server
        1. `JUPYTER_LOCAL_PORT`: internal jupyter server port, if you want to expost it via cloudfalre, must be same as `CLOUDFLARED_LOCAL_PORT`
        1. `JUPYTER_PASSWORD`
    1. `V2RAY`: `0/1`, enable v2ray server
        1. `V2RAY_LOCAL_PORT`: internal v2ray server port. Must be unique to other services
        1. `V2RAY_PATH`: v2ray path. 
        1. `V2RAY_UUIDS`: split uuid with `:`
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