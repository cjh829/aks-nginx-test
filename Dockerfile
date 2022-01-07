FROM nginx:1.20.2

COPY index2.html /usr/share/nginx/html/index2.html
RUN chmod +r /usr/share/nginx/html/index2.html