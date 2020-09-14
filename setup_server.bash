# !/bin/bash

# Author: Pietro Malky
# Date: 09/13/2020
# Purpose: Help Linux and MacOS users setup NGINX HTTPS and proxy pass



# ======== SETUP LOCAL VARIABLES ========
# initial variable declarations
OS="$OSTYPE"
DOMAIN="TEMP"
SUB_DOMAIN="TEMP"
TOP_LEVEL_DOMAIN="TEMP"
FULL_CONFIG_FILE_PATH="TEMP"
FULL_DOMAIN_NAME="TEMP"
SEARCH_STRING="_SUBDOMAIN_._DOMAIN_._TOPLEVELDOMAIN_"
STATIC_FILE_DIR_PATH="TEMP"
BASE_CONFIG_FILE_PATH="/etc/nginx/conf.d" # CHANGE ME AFTER DEBUGGING


# ======== HANDLE KILLING EXISTING PROCESSES ON PORT 80 FIRST ========
# sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill



# ======== GET USER INPUT ========
# read user input for domain, sub-domain and top-level-domain
read -p $'\e[36mEnter your domain (e.g. github): \e[0m' DOMAIN
read -p $'\e[36mEnter your sub-domain (e.g. www): \e[0m' SUB_DOMAIN
read -p $'\e[36mEnter your top-level-domain (e.g. com): \e[0m' TOP_LEVEL_DOMAIN
FULL_DOMAIN_NAME="$SUB_DOMAIN.$DOMAIN.$TOP_LEVEL_DOMAIN"


# echo domain back to user
yellow='\e[33m'
nc='\e[0m'
echo -e $'\n\e[36mYour full domain is: ' $'\e[33m' "$FULL_DOMAIN_NAME" $'\e[0m'


# ======== OS-specific command generation ========
# package manager
PKG_QUERY="TEMP"

# sed command varies from MacOS to Linux
SED="TEMP"

if [[ "$OS" == "linux-gnu"* ]]; then
    PKG_QUERY="dpkg-query --list"
    SED="sed -i"
elif [[ "$OS" == "darwin"* ]]; then
    PKG_QUERY="brew list"
    SED="sed -i ''"
else
    echo -e $'\e[31mCannot run setup script on your OS:' "$FULL_CONFIG_FILE_PATH" $'. Exiting now\e[0m'
    exit 1
fi


# # ======== CERTBOT CERTIFICATE CREATION HANDLING ========
# check certbot is installed on machine, if not, warn user and quit
CERTBOT_COUNT=`$PKG_QUERY | grep -i -c -w "certbot"`
if [[ "$CERTBOT_COUNT" > 0 ]]; then 
    echo "Certbot is installed"
else    
    echo "Certbot is NOT installed"
    exit 1
fi

# create ssl certificate with certbot
sudo certbot certonly --standalone -d "$FULL_DOMAIN_NAME"
echo "Created SSL certificate using Certbot and Let's Encrypt"


# # ======== NGINX CONFIG FILE HANDLING ========
# check nginx is installed on machine, if not, warn user and quit
NGINX_COUNT=`$PKG_QUERY | grep -i -c -w "nginx"`
if [[ "$NGINX_COUNT" > 0 ]]; then 
    echo "NGINX is installed"
else    
    echo "NGINX is NOT installed"
    exit 1
fi



# copy config file to target location
FULL_CONFIG_FILE_PATH="$BASE_CONFIG_FILE_PATH/$FULL_DOMAIN_NAME.conf"
sudo cp "[sub domain].[domain].[top level domain].conf" "$FULL_CONFIG_FILE_PATH"
echo -e $'\e[36mCreated NGINX conf file at: ' $'\e[33m' "$FULL_CONFIG_FILE_PATH" $'\e[0m'


# add path where static files will be served from
read -p $'\n\e[36mFull path to directory containing static files you want to serve: \e[0m' STATIC_FILE_DIR_PATH


# modify config file to include server name based on user's OS
sudo $SED "s/$SEARCH_STRING/$FULL_DOMAIN_NAME/g" "$FULL_CONFIG_FILE_PATH"
sudo $SED "s+_STATICFILEDIRECTORY_+$STATIC_FILE_DIR_PATH+g" "$FULL_CONFIG_FILE_PATH"
echo -e $'\n\e[36mCreated NGINX config file to fit your domain\e[0m'


# ask user if they have API's they want to add to the proxy passthrough


