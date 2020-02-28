# multidomain
END GOAL:
2 domains > elb > ingress controller with paths > nginx pods with host server blocks

testing locally, add to /etc/hosts:
127.0.0.1 1.mcmattco.com 2.mcmattco.com

# build dockerfile
docker build -t nginx-multidomain .

# run container
docker run -d -p 80:80 nginx-multidomain

# hit both domains, get different pages
1.mcmattco.com
2.mcmattco.com
