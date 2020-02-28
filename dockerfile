FROM nginx:latest

RUN mkdir /usr/share/nginx/html/1 && \
    mkdir /usr/share/nginx/html/2 && \
    echo "this is site 1" > /usr/share/nginx/html/1/index.html && \
    echo "this is site 2" > /usr/share/nginx/html/2/index.html 

COPY 1.conf /etc/nginx/conf.d/1.conf
COPY 2.conf /etc/nginx/conf.d/2.conf

EXPOSE 80
