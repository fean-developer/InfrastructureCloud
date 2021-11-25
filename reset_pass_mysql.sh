#!/bin/bash
sudo service mysql stop
sudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables"
sudo service mysql start mysqld
sudo mysql -u root -e "UPDATE mysql.user SET authentication_string = '', password_expired = 'N' WHERE User = 'root' AND (Host = 'localhost' OR Host = '%');"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';"
sudo service mysql stop mysqld
sudo systemctl unset-environment MYSQLD_OPTS
sudo service mysql start mysqld
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"
sudo sed -i 's/bind-address		= 127.0.0.1/bind-address		= 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart mysqld