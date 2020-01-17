# server-info-app

The server-info-app is a web app that pulls and displays hardware and software information about the server that it is running on.

This repository contains all scripts necessary to automatically setup all server components and deploy server-info-app components to a fresh installation of Ubuntu (tested with *Ubuntu 19.10*). Clone this repository to a clean Ubuntu installation and run `install.sh` as superuser. The script will install and configure an Nginx server, deploy the app and more.

See [ARCHITECTURE.md](ARCHITECTURE.md) for a summary of how the server-info-app is structure.

## Installation

To install the server-info-app on a fresh Ubuntu installation:

```shell
git clone https://github.com/briandesousa/server-info-app-automation.git
cd server-info-app-automation
sudo ./install.sh
```

To remove and re-install the server-info-app:

```shell
git clone https://github.com/briandesousa/server-info-app-automation.git
cd server-info-app-automation
sudo ./install.sh uninstallfirst
```

## Nginx server information

Important information about the Nginx server used to host the **server-info-app**.

### Commands

Restart Nginx with `sudo systemctl restart nginx`.

Check the status of Nginx with `sudo systemctl status nginx`.

### Important files and directories

* `/etc/nginx` - installation root
* `/etc/nginx/sites-available/` - server block Nginx config files
* `/etc/nginx/sites-enabled/` - symbolic links to server block config files, used to enable the server block
* `/var/log/nginx/access.log` - access log
* `/var/log/nginx/error.log` - error log