FROM ubuntu
MAINTAINER cedric@zestprod.com
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y \
  wget \
  php5 \
  php5-mysql \
  php5-ldap \
  php5-xmlrpc \
  curl \
  php5-curl \
  php5-gd
RUN a2enmod rewrite && service apache2 stop
WORKDIR /var/www/html
COPY start.sh /opt/
RUN chmod +x /opt/start.sh
CMD /opt/start.sh
EXPOSE 80
