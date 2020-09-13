# !/bin/bash

# Author: Pietro Malky
# Date: 09/13/2020
# Purpose: Help Linux and MacOS users setup NGINX HTTPS and proxy pass
# read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

# initial variable declarations
OS="$OSTYPE"
DOMAIN="TEMP"
SUB_DOMAIN="TEMP"
TOP_LEVEL_DOMAIN="TEMP"
BASE_CONFIG_FILE_PATH="/Users/pietromalky/Desktop" # CHANGE ME AFTER DEBUGGING
FULL_CONFIG_FILE_PATH="TEMP"


# check what operating system user is running
if [[ "$OS" == "linux-gnu"* ]]; then
    echo "You're on linux"
elif [[ "$OS" == "darwin"* ]]; then
    echo "You're on mac"
else
    echo "Cannot run setup script on your OS: $OS"
    exit 1
fi


# read user input for domain, sub-domain and top-level-domain
read -p "Enter your domain: " DOMAIN
read -p "Enter your sub-domain: " SUB_DOMAIN
read -p "Enter your top-level-domain: " TOP_LEVEL_DOMAIN


# echo domain back to user
echo "Your fully qualified domain is: " "$SUB_DOMAIN"."$DOMAIN"."$TOP_LEVEL_DOMAIN"


# copy config file to target location
FULL_CONFIG_FILE_PATH="$BASE_CONFIG_FILE_PATH/$SUB_DOMAIN.$DOMAIN.$TOP_LEVEL_DOMAIN.conf"
cp "[sub domain].[domain].[top level domain].conf" $FULL_CONFIG_FILE_PATH
echo "Created NGINX conf file at $FULL_CONFIG_FILE_PATH"
