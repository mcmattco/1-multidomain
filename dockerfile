FROM nginx:latest

RUN mkdir /usr/share/nginx/html/1 && \
    mkdir /usr/share/nginx/html/2 && \
    echo "this is site 1" > /usr/share/nginx/html/1/index.html && \
    echo "this is site 2" > /usr/share/nginx/html/2/index.html 

COPY multidomain.conf /etc/nginx/conf.d/multidomain.conf

EXPOSE 80 443
