# Zabbix Automation Scripts
This repository contains Bash scripts for automating the installation and configuration of Zabbix Server, Zabbix Agent, and Zabbix Proxy. These scripts aim to simplify the deployment process and ensure consistent configurations across different environments.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Zabbix Server](#zabbix-server)
  - [Zabbix Agent](#zabbix-agent)
  - [Zabbix Proxy](#zabbix-proxy)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Ensure you have the following prerequisites before running the scripts:

- [ ] Linux operating system (tested on Ubuntu 20.04)
- [ ] Bash shell
- [ ] Root or sudo access

## Usage

### Zabbix Server

1. Clone this repository:

   ```bash
   git clone https://github.com/vahid97gh/Zabbix.git
   cd Zabbix
   ```
2. Run the Zabbix Server script:
 
   ```bash
   ./zabbix-server.sh
   ```
### Zabbix Agent

1. Clone this repository:

   ```bash
   git clone https://github.com/vahid97gh/Zabbix.git
   cd Zabbix
   ```
2. Run the Zabbix Agent script:

   ```bash
   ./zabbix-agent.sh
   ```
### Zabbix Proxy

1. Clone this repository:

   ```bash
   git clone https://github.com/vahid97gh/Zabbix.git
   cd Zabbix
   ```
2. Run the Zabbix Proxy script:

   ```bash
   ./zabbix-proxy.sh
   ```
### Configuration

Customize the configuration files as needed. You can find the Zabbix Server, Agent, and Proxy configuration files in the config directory.

1. Zabbix server config file:

   ```bash
   vim /etc/zabbix/zabbix_server.conf
   ```
2. Zabbix Agent config file:

   ```bash
   vim /etc/zabbix/zabbix_agentd.conf
   ```
3. Zabbix Proxy config file:

   ```bash
   vim /etc/zabbix/zabbix_proxy.conf
   ```
   
### Contributing

Feel free to contribute by opening issues or submitting pull requests. Your feedback and improvements are highly appreciated.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
