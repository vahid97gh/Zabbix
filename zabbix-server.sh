#!/bin/bash/
apt update -y
timedatectl set-timezone Asia/Tehran
hostnamectl set-hostname zabbix.example.com
Resolv= /etc/resolv.conf
if [ -f "$Resolv"]; then
echo "resolv is exist!"
else
sudo touch /etc/resolv.conf
echo "nameserver 185.51.200.2 \nnameserver 178.22.122.100" > /etc/resolv.conf
fi
File=zabbix-release_6.4-1+ubuntu20.04_all.deb
if [ -f "$File"]; then
echo "file does exist!"
else
echo "file does not exist!"
sudo unlink /etc/resolv.conf
sudo touch /etc/resolv.conf
echo "nameserver 178.22.122.100 \nnameserver 185.51.200.2" > /etc/resolv.conf
wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu20.04_all.deb
fi
sudo dpkg -i zabbix-release_6.4-1+ubuntu20.04_all.deb
sudo apt update -y
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent -y
sudo apt install software-properties-common -y
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
bash mariadb_repo_setup --mariadb-server-version=10.6
apt update -y
sudo apt -y install mariadb-common mariadb-server-10.6 mariadb-client-10.6 -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo unlink /etc/resolv.conf
sudo touch /etc/resolv.conf
echo "nameserver 8.8.8.8 \nnameserver 4.2.2.4" > /etc/resolv.conf
sudo mysql -u root -p <<EOF
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'password';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
EOF
cat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
sudo mysql -u root -p <<EOF
set global log_bin_trust_function_creators = 0;
EOF
sed -i 's/# DBPassword=/DBPassword=password/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/# listen 8080;/listen 8080;/' /etc/zabbix/nginx.conf
sed -i 's/# server_name example.com;/server_name zabbix.example.com;/' /etc/zabbix/nginx.conf
sudo systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm
sudo systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm
service_name="zabbix-server"
if systemctl is-active --quiet "$service_name.service" ; then
echo "$service_name running"
else
systemctl start "$service_name"
fi
