#!/usr/bin/env bash

DBHOST=localhost
DBNAME=scharlab
DBUSER=root
DBPASSWD=dbpass


apt-get update
apt-get upgrade

apt-get -y install apache2

VHOST=$(cat <<EOF
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Directory "/var/www/html">
                AllowOverride all
        </Directory>

</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

a2enmod rewrite

apt-add-repository -y ppa:ondrej/php
apt-get update
apt-get -y install php5.6 php5.6-mcrypt php5.6-curl php5.6-cli php5.6-mysql php5.6-gd libapache2-mod-php5.6
sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/5.6/apache2/php.ini

echo "mysql-server mysql-server/root_password password $DBPASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
apt-get -y install mysql-server-5.7 mysql-client-5.7

mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME"
mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'"

service apache2 restart