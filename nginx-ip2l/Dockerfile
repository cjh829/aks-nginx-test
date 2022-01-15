#copy from https://github.com/theplant/ip2location-nginx/blob/master/Base.Dockerfile for adding ip2location module

FROM nginx:1.20.2 as builder

RUN apt-get update -y && \
    apt-get install -y build-essential dh-autoreconf unzip wget libpcre3 libpcre3-dev zlib1g zlib1g.dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir /nginx-dev && \
    cd /nginx-dev \
    && wget https://github.com/chrislim2888/IP2Location-C-Library/archive/master.zip \
    && unzip master.zip && rm master.zip \
    && cd IP2Location-C-Library-master \
    && autoreconf -i -v --force \
    && ./configure \
    && make \
    && make install \
    && ldconfig \
    && cd data \
    && perl ip-country.pl \
    && cd /nginx-dev \
    && wget https://github.com/ip2location/ip2location-nginx/archive/master.zip \
    && unzip master.zip && rm master.zip \
    && wget http://nginx.org/download/nginx-1.20.2.tar.gz \
    && tar xvfz nginx-*.tar.gz && rm nginx-*.tar.gz
RUN nginx -V 2> $$ \
    && nginx_configure_arguments="`cat $$ | grep 'configure arguments:' | awk -F: '{print $2}'` --add-module=/nginx-dev/ip2location-nginx-master" \
    && rm -rf $$ \
    && cd /nginx-dev/nginx-1.20.2 \
    && eval ./configure $nginx_configure_arguments \
    && make \
    && make install

FROM nginx:1.20.2
ENV LD_LIBRARY_PATH /usr/local/lib
COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /nginx-dev/nginx-1.20.2/objs/nginx /usr/sbin/nginx
RUN mkdir /etc/ip2location
COPY DB1.BIN /etc/ip2location/DB1.BIN
