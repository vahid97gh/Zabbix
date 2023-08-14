#!/bin/bash/
Resolv= /etc/resolv.conf
if [ -f "$Resolv"]; then
echo "resolv is exist!"
else
sudo touch /etc/resolv.conf
echo "nameserver 8.8.8.8 \nnameserver 4.2.2.4" > /etc/resolv.conf
fi
apt update -y
File=/home/ubuntu/zabbix-release_6.0-4%2Bubuntu20.04_all.deb
if [ -f "$File"]; then
echo "file does exist!!"
else
echo "file does not exist!!"
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bubuntu20.04_all.deb
fi
sudo dpkg -i zabbix-release_6.0-4%2Bubuntu20.04_all.deb
sudo apt update
sudo apt install zabbix-agent -y
service_name="zabbix-agent"
if systemctl is-active --quiet "$service_name.service" ; then
echo "$service_name running"
else
systemctl start "$service_name"
fi
sed -i 's/LogFileSize=0/LogFileSize=1/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/Hostname=Zabbix server/Hostname=zabbix-agent/' /etc/zabbix/zabbix_agentd.conf
sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent
