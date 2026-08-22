#!/bin/bash
dnf update -y
dnf install httpd -y
dnf install -y php php-mysqlnd
dnf install mariadb105-server -y
systemctl start httpd
systemctl enable httpd
systemctl start mariadb
systemctl enable mariadb
sleep 10
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress /var/www/html/
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'user1'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
sed -i 's/database_name_here/wordpress/' /var/www/html/wordpress/wp-config.php
sed -i 's/username_here/user1/' /var/www/html/wordpress/wp-config.php
sed -i 's/password_here/password/' /var/www/html/wordpress/wp-config.php
chown -R apache:apache /var/www/html/wordpress/