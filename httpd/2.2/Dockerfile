FROM btheu/centos:6.4

MAINTAINER Benoit Theunissen <benoit.theunissen@gmail.com>

WORKDIR /etc/httpd/

RUN yum install -y httpd mod_perl mod_ssl libapreq2 \
  && yum clean all

COPY httpd-foreground /usr/local/bin/

EXPOSE 80

VOLUME ["/etc/httpd/"]

CMD ["httpd-foreground"]
