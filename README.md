# multidomain project
END GOAL:

2 subdomains > aws elb > k8s ingress controller with hosts defined > nginx pod with host server blocks

and TLS somewhere

## Build and push container

https://phoenixnap.com/kb/how-to-set-up-nginx-server-blocks-virtual-hosts-centos-7

    docker build -t nginx-multidomain .
    docker tag 577 mcmattco/nginx_multidomain:v1
    docker push mcmattco/nginx_multidomain:v1 

## deploy container in k8s

    k create deployment --image mcmattco/nginx-multidomain:v1 nginx-multidomain
    k expose deployment nginx-multidomain --port 80

## setup nginx-ingress controller

    k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml
    k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/aws/service-l4.yaml
    k apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/aws/patch-configmap-l4.yaml

This sets up the ELB, check it's status and get the external DNS name with `k get svc -n nginx-ingress`

Create CNAME records using ELB name for relevant subdomains (a.mcmattco.com, b.mcmattco.com, and test.mcmattco.com in this case)

## setup cert-manager

    k create namespace cert-manager
    k apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.13.1/cert-manager.yaml
    k get pods --namespace cert-manager
    k apply -f prod_issuer.yaml


## apply ingress manifest and check status

    k apply -f nginx_ingress.yaml
    k a describe ingress
