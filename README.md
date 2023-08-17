# Install Zabbix , Zabbix proxy and Zabbix agent with bash scripting in ubuntu
bash-zabbix-agent
This file is the installation bash code of Zabbix-agent.
To install the Zabbix agent you can run this bash script file in your Ubuntu server and monitor it in your main Zabbix.
run this command:
$ bash zabbix-agent.sh
After installing the Zabbix agent You can go to /etc/zabbix/zabbix-agentd.conf and make changes .
In the line of server= and server active, you must add your main Zabbix ip.
Enjoy it!
