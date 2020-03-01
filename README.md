# multidomain project
END GOAL:

2 subdomains > aws elb > k8s ingress controller with paths > nginx pods with host server blocks

and TLS somewhere

## testing locally, add to /etc/hosts:

127.0.0.1 1.mcmattco.com 2.mcmattco.com

## build container

https://phoenixnap.com/kb/how-to-set-up-nginx-server-blocks-virtual-hosts-centos-7

docker build -t nginx-multidomain .

## run container
docker run -d -p 80:80 nginx-multidomain

## hit both domains, get different pages
1.mcmattco.com

2.mcmattco.com
