###
# Install Nginx, Gunicor (WSGI server) and Flask. This script must be **run as superuser**.
#
# To run the automation for the first time:
#   sudo ./install.sh
#
# To re-run the automation and remove a previous installation first:
#   sudo ./install.sh uninstallfirst
#
# Example of running automation from this repository on fresh Ubuntu installation:
#   sudo apt-get install git
#   git clone https://github.com/briandesousa/server-info-app-automation.git
#   cd server-info-app-automation
#   sudo chmod +x install.sh
#   sudo ./install.sh
###

APP_NAME="server-info-app"

print_info(){
  printf "\n[INFO] $1\n"
}

print_error(){
  printf "\n[ERROR] $1\n"
}


# attempt to uninstall Nginx first if requested
if [ ! -z $1 ]
then
  if [ $1 = "uninstallfirst" ]
  then
    print_info "Uninstalling Nginx first"
    sudo apt-get remove --purge nginx -y
    sudo apt-get autoremove -y
    sudo rm -rf /var/www/$APP_NAME
    sudo rm -rf /etc/nginx/sites-available/$APP_NAME
    sudo rm -rf /etc/nginx/sites-enabled/$APP_NAME
  fi
fi


# install Nginx if its not already installed
command -v nginx
if [ $? -ne 0 ]
then
  print_info "Installing stable version of Nginx from Ubuntu package repository"
  sudo apt-get update
  sudo apt-get install nginx -y
else
 print_info "Nginx is already installed"
fi
nginx -v

# check if Nginx service is active
systemctl is-active -q nginx
if [ $? -ne 0 ]
then
  print_error "Nginx service is not running"
  exit 1
else
  print_info "Nginx service is running"
fi

# check if Nginx is accessible via HTTP port 80
http_status=$(curl -s -o /dev/null -w "%{http_code}" http://0.0.0.0:80)
if [ $http_status -ne 200 ]
then
  print_error "Nginx test at 0.0.0.0:80 failed, HTTP status code $http_status returned"
else
  print_info "Nginx test at 0.0.0.0:80 passed, HTTP status code $http_status returned"
fi

# setup Nginx server block
SERVER_BLOCK_PATH="/var/www/$APP_NAME"
sudo mkdir -p $SERVER_BLOCK_PATH/html
sudo chown -R $USER:$USER $SERVER_BLOCK_PATH
sudo chmod -R 755 $SERVER_BLOCK_PATH

# TODO download React UI package from CI system and expand it to server block path
# TODO if Git is required for deployment, check and install with `sudo apt-get install git` first
sudo echo "Future server-info-app React UI" > $SERVER_BLOCK_PATH/index.html

# enable and test Nginx server block configuration
sudo cp ./nginx-server-block-config /etc/nginx/sites-available/$APP_NAME
sudo ln -s /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enabled/
sudo nginx -t

sudo systemctl restart nginx

# TODO hit "selftest" endpoint on UI/API to validate application is working