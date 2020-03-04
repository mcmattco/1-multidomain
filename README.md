# Multidomain project
INITIAL END GOAL:

2 subdomains > aws elb > k8s ingress controller routing by hosts > nginx pod with host server blocks

and TLS somewhere using cert-manager

## Build and push container
Nginx container with server blocks routing by host to two sites

https://phoenixnap.com/kb/how-to-set-up-nginx-server-blocks-virtual-hosts-centos-7

    docker build -t nginx-multidomain .
    docker tag 577 mcmattco/nginx_multidomain:v1
    docker push mcmattco/nginx_multidomain:v1 

## Setup nginx-ingress controller

https://kubernetes.github.io/ingress-nginx/deploy/#aws

    k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml
    k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/aws/service-l4.yaml
    k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/aws/patch-configmap-l4.yaml

This sets up the ELB, check it's status and get the external DNS name with `k get svc -n nginx-ingress`

Create CNAME records using ELB name for relevant subdomains (a.mcmattco.com, b.mcmattco.com, and test.mcmattco.com in this case)

## Setup cert-manager and apply issuer manifest using Let's Encrypt

https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes#step-2-%E2%80%94-setting-up-the-kubernetes-nginx-ingress-controller

    k create namespace cert-manager
    k apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.13.1/cert-manager.yaml
    k get pods --namespace cert-manager   # wait for all three pods to be running
    k apply -f prod_issuer.yaml

## Apply manifest to deploy pods, service, and ingress

    k apply -f nginx_multidomain.yaml
    k a describe ingress   # to confirm certs have finished issuing
