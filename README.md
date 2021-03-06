# RootlessRouterDocker
This is the docker image for this project

https://github.com/KusakabeSi/RootlessRouter-UML

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
docker buildx build  --platform linux/amd64 -t kskbsi/rootlessrouter . --output="type=docker"

#Test in localhost
docker run -it --rm --env-file=env_file_hk --name=azhk kskbsi/rootlessrouter 
docker exec -it azhk bash
```

Build and push
```bash
docker buildx build  --platform linux/amd64 -t kskbsi/rootlessrouter . --push
```

## Environment Variables

1. `GIT_REPO_ADDR` : `0/1`, run `apt update` at startup
1. `SSH_KEY` : `0/1`, run `apt upgrade` at startup
1. `UPTIME_LOG` : `0/1`, enable uptime log at `/root/.log/uptime.log`
