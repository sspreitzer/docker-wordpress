FROM centos:7

ENV WORDPRESS_VERSION=4.8

RUN yum install -y httpd php php-mysql && \
    rm -f /etc/httpd/conf.d/welcome.conf && \
    yum clean all && \
    chmod 770 /run/httpd && \
    chown apache:apache /var/www/html && \
    chmod 770 /var/www/html && \
    sed -i 's|Listen 80|Listen 8080|g' /etc/httpd/conf/httpd.conf && \
    sed -i 's|ErrorLog .*|ErrorLog /dev/stderr|g' /etc/httpd/conf/httpd.conf && \
    sed -i 's|CustomLog .*|CustomLog /dev/stdout combined|g' /etc/httpd/conf/httpd.conf && \
    curl https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz | tar -xzf - -C /opt

ADD assets/entrypoint.sh /entrypoint.sh
ADD assets/wp-config.php /opt/wordpress/wp-config.php

EXPOSE 8080

VOLUME /var/www/html

USER apache

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]


