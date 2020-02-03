
#LOAD BASE IMAGE
FROM debian:buster


#INSTALL DEPENDENCIES
RUN apt-get update && apt-get install -y \
    nginx \
	mariadb-server \
	php7.3 \
	php-mysql \
	php-fpm \
	php-cli \
	php-json \
	php-mbstring \
	wget

#COPY CONTENT
COPY ./srcs/mysql_setup.sql /var/
COPY ./srcs/wordpress.sql /var/
COPY ./srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

#INSTALL WORDPRESS
WORKDIR /var/www/html/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xf ./latest.tar.gz && rm -rf latest.tar.gz
RUN chmod 755 -R wordpress
COPY ./srcs/wp-config.php /var/www/html/wordpress

#INSTALL PHPMYADMIN
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz
RUN tar xf phpMyAdmin-4.9.1-english.tar.gz && rm -rf phpMyAdmin-4.9.1-english.tar.gz
RUN mv phpMyAdmin-4.9.1-english /var/www/html/wordpress/phpmyadmin
COPY ./srcs/config.inc.php /var/www/html/wordpress/phpmyadmin

# SETUP SERVER AND SSL CERTIFICATE
RUN service mysql start && mysql -u root mysql < /var/mysql_setup.sql && mysql wordpress -u root --password= < /var/wordpress.sql
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=ES/ST=75/L=Madrid/O=42/CN=pablomar' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt
RUN chown -R www-data:www-data *
RUN chmod 755 -R *

#START SERVICE
CMD service mysql start && \
	service php7.3-fpm start && \
	service nginx start && \
	sleep infinity

EXPOSE 80 443
