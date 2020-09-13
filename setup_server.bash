# !/bin/bash

# Author: Pietro Malky
# Date: 09/13/2020
# Purpose: Help Linux and MacOS users setup NGINX HTTPS and proxy pass
# read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1



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
BASE_CONFIG_FILE_PATH="/Users/pietromalky/Desktop" # CHANGE ME AFTER DEBUGGING

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




# ======== CERTBOT CERTIFICATE CREATION HANDLING ========
# check certbot is installed on machine, if not, install it




# ======== NGINX CONFIG FILE HANDLING ========
# check nginx is installed on machine, if not, install it


# copy config file to target location
FULL_CONFIG_FILE_PATH="$BASE_CONFIG_FILE_PATH/$FULL_DOMAIN_NAME.conf"
cp "[sub domain].[domain].[top level domain].conf" "$FULL_CONFIG_FILE_PATH"
echo -e $'\e[36mCreated NGINX conf file at: ' $'\e[33m' "$FULL_CONFIG_FILE_PATH" $'\e[0m'


# add path where static files will be served from
read -p $'\n\e[36mFull path to directory containing static files you want to serve: \e[0m' STATIC_FILE_DIR_PATH


# modify config file to include server name based on user's OS
if [[ "$OS" == "linux-gnu"* ]]; then
    sed -i "s/$SEARCH_STRING/$FULL_DOMAIN_NAME/g" "$FULL_CONFIG_FILE_PATH"
    sed -i "s+_STATICFILEDIRECTORY_+$STATIC_FILE_DIR_PATH+g" "$FULL_CONFIG_FILE_PATH"
elif [[ "$OS" == "darwin"* ]]; then
    sed -i '' "s/$SEARCH_STRING/$FULL_DOMAIN_NAME/g" "$FULL_CONFIG_FILE_PATH"
    sed -i '' "s+_STATICFILEDIRECTORY_+$STATIC_FILE_DIR_PATH+g" "$FULL_CONFIG_FILE_PATH"
else
    echo -e $'\e[31mCannot run setup script on your OS:' "$FULL_CONFIG_FILE_PATH" $'. Exiting now\e[0m'
    exit 1
fi
echo -e $'\n\e[36mCreated NGINX config file to fit your domain\e[0m'


# ask user if they have API's they want to add to the proxy passthrough



# ======== NGINX SERVER RUNNING HANDLING ========
# kill all current processes on port 80


# run NGINX server