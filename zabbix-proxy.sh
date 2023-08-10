#!/bin/bash/
apt update -y
timedatectl set-timezone Asia/Tehran
hostnamectl set-hostname zabbix-proxy
Resolv= /etc/resolv.conf
if [ -f "$Resolv"]; then
echo "resolv is exist!"
else
sudo touch /etc/resolv.conf
echo "nameserver 185.51.200.2 \nnameserver 178.22.122.100" > /etc/resolv.conf
fi
File=/home/ubuntu/zabbix-release_6.0-4+ubuntu20.04_all.deb
if [ -f "$File"]; then
echo "file does exist!"
else
echo "file does not exist!"
sudo unlink /etc/resolv.conf
sudo touch /etc/resolv.conf
echo "nameserver 185.51.200.2 \nnameserver 178.22.122.100" > /etc/resolv.conf
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb
fi
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo apt update -y
sudo apt install zabbix-proxy-mysql zabbix-sql-scripts -y
sudo apt install software-properties-common -y
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
bash mariadb_repo_setup --mariadb-server-version=10.6
apt update -y
sudo apt -y install mariadb-common mariadb-server-10.6 mariadb-client-10.6 -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo unlink /etc/resolv.conf
sudo touch /etc/resolv.conf
echo "nameserver 8.8.8.8"> /etc/resolv.conf
sudo mysql -u root -p <<EOF
create database zabbix_proxy character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'password';
grant all privileges on zabbix_proxy.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
EOF
cat /usr/share/zabbix-sql-scripts/mysql/proxy.sql | mysql --default-character-set=utf8mb4 -uzabbix -ppassword zabbix_proxy
sudo mysql -u root -p <<EOF
set global log_bin_trust_function_creators = 0;
EOF
sed -i 's/Hostname=Zabbix proxy/Hostname=Zabbix-proxy/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/# LogFileSize=/LogFileSize=1/' /etc/zabbix/zabbix_proxy.conf
sed -i 's/# DBPassword=/DBPassword=password/' /etc/zabbix/zabbix_proxy.conf
sudo systemctl restart zabbix-proxy
sudo systemctl enable zabbix-proxy
service_name="zabbix-proxy"
if systemctl is-active --quiet "$service_name.service" ; then
echo "$service_name running"
else
systemctl start "$service_name"
fi
