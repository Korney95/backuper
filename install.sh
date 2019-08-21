#!/bin/bash

sitename=huawei.sk.ru
dir=/root/default

#mkdir /var/www/$sitename &&

apt install -y dh-php php php-common php-gd php-gettext php-mcrypt php-pear php-phpseclib php-tcpdf php-xml php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-fpm php7.0-gd php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline php7.0-xml &&

apt install -y nginx &&

apt install -y mysql-server &&

apt install -y phpmyadmin &&

apt install -y exim4 &&

#dpkg-reconfigure exim4-config &&

echo "" > /etc/nginx/sites-enabled/default &&

git clone https://github.com/Korney95/default.git &&

cat $dir/default > /etc/nginx/sites-enabled/default && 

cat $dir/php.ini > /etc/php/7.0/fpm/php.ini &&

cat $dir/template.conf > /etc/php/7.0/fpm/pool.d/$sitename.conf &&

sed -i  -e "s/pochtatech.sk.ru/$sitename/g" /etc/php/7.0/fpm/pool.d/$sitename.conf &&

service php7.0-fpm restart &&

#ln -s /usr/share/phpmyadmin/ /var/www/html/phpmyadmin &&

nginx -t && nginx -s reload 
