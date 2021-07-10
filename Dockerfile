#
# Dockerfile for Apache Web Server
#
FROM ubuntu:18.04
MAINTAINER Anton Hibchenko <sl1pgcp@gmail.com>

ENV APACHE_VERSION="2.4.29-1ubuntu4.16"

RUN apt-get update && apt-get install -y apache2=${APACHE_VERSION}
RUN groupadd -r hillel_devops && useradd -r -s /bin/bash -m -g hillel_devops hillel_devops && /usr/sbin/a2dissite 000-default.conf

COPY apache_ports.conf /etc/apache2/
COPY virtualhost.conf /etc/apache2/sites-enabled/

WORKDIR /var/www/html/

COPY --chown=www-data:www-data index.html .

EXPOSE 8080/tcp

CMD ["apache2ctl", "-D", "FOREGROUND"]