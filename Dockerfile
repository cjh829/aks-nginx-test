FROM cjh829.azurecr.io/nginx-ip2l:1.20.2v2
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY nginx/fastcgi_params /etc/nginx/fastcgi_params
COPY nginx/mime.types /etc/nginx/mime.types
COPY nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/html /usr/share/nginx/html
RUN chmod +r /usr/share/nginx/html
