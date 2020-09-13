# !/bin/bash

# Author: Pietro Malky
# Date: 09/13/2020
# Purpose: Help Linux and MacOS users setup NGINX HTTPS and proxy pass


# initial variable declarations
OS="$OSTYPE"
DOMAIN="TEMP"
SUB_DOMAIN="TEMP"
TOP_LEVEL_DOMAIN="TEMP"



# check what operating system user is running
if [[ "$OS" == "linux-gnu"* ]]; then
    echo "You're on linux"
elif [[ "$OS" == "darwin"* ]]; then
    echo "You're on mac"
else
    echo "Cannot run setup script on your machine"
fi


# read user input for domain, sub-domain and top-level-domain
read -p "Enter your domain: " DOMAIN
read -p "Enter your sub-domain: " SUB_DOMAIN
read -p "Enter your top-level-domain: " TOP_LEVEL_DOMAIN

# echo domain back to user
echo "Your fully qualified domain is: " "$SUB_DOMAIN"."$DOMAIN"."$TOP_LEVEL_DOMAIN"
