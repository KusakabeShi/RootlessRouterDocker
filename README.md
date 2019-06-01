# Docker-image-for-azure-appservice-container
This is a dockerfile that create an docker image for azure app service. 

It contain crontab and service conrol and runit. similar to https://github.com/phusion/baseimage-docker , but this is Ubuntu 18.04.

And other stuff. Such as ssh(https://docs.microsoft.com/en-us/azure/app-service/containers/app-service-linux-ssh-support).

##How to use it:
'''bash
In this case, we use "ubuntu-test" as image name. you can use wathever you want.

docker build -t ubuntu-test . --no-cache
docker tag ubuntu-test your-docker-hub/ubuntu-test
docker push your-docker-hub/ubuntu-test

docker run -d ubuntu-test
'''
