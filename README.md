# NGINX-HTTPS-Setup

## Before you begin

- Ensure you have "sudo" access on your machine.
- Ensure you have a domain name registered and is working.
- Ensure the server you'll use for HTTP/HTTPS traffic has ports 80 and 443 enabled and you're pointing to your domain name.

### Install Certbot and NGINX on your machine

#### Ubuntu

```bash
sudo apt-get update
sudo apt-get install certbot
sudo apt-get install nginx
```

#### MacOS

```bash
sudo brew install certbot
sudo brew install nginx
```

- You must have Homebrew installed in order to run the above commands on MacOS

### Kill any existing processes running on port 80

```bash
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
```

## Running the script

```bash
./setup_server.bash
```

The script will ask you to input your entire domain.
e.g. If your full target domain is _blog.johnnyappleseed.com_, you'll be asked to input it just like that.

Follow the remaining of the steps prompted by the script.

## NGINX

This setup script will save the generated NGINX conf file at the following location on your machine:

```
/etc/nginx/conf.d/[sub domain].[domain].[top level domain].conf
```

For the following example domain name:

- Sub-domain: "blog",
- Domain: "johnnyappleseed",
- Top-level-domain: "com"

The NGINX conf file will be saved at:

```
/etc/nginx/conf.d/blog.johnnyappleseed.com.conf
```

## Certbot

Certbot uses Let's Encrypt as the C.A. (certificate authority) to manage your SSL certificate.

It will automatically create and manage your private key and full certificate at the following location:

```

/etc/letsencrypt/live/[sub domain].[domain].[top level domain]/
|--- fullchain.pem
|--- privkey.pem

```

## Additional notes

The base NGINX conf file was generated using [Mozilla's SSL Config tool](https://ssl-config.mozilla.org/#server=nginx&version=1.14.0&config=modern&openssl=1.1.1&guideline=5.6)

- Mozilla Guideline v5.6
- nginx 1.14.0
- OpenSSL 1.1.1
- modern configuration

## Additional modifications

If you wish to modify the NGINX config file, you can do so using your text editor of choice (VIM, NANO, EMACS, etc.).

You can add proxy redirects to your web APIs or WebSocket applications by modifying the NGINX config (conf) file generated. A template for both scenarios is already provided, simply un-comment the applicable blocks.

## Questions? Get in touch

[Email](mailto:pm95dev@gmail.com?subject=NGINX%20HTTPS%20Setup)

[LinkedIn](https://linkedin.com/in/pietro-malky)

## Additional Notes

### Steps to take to troubleshoot tool (use at your own risk)

0. Kill all processes on port 80 (http)

```bash
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
```

1. Purge (remove) NGINX and Certbot from your machine

```bash
sudo apt-get update
sudo apt-get purge nginx nginx-common
sudo apt-get purge certbot
```

2. Delete folders containing LetsEncrypt and NGINX data

```bash
sudo rm -rf /etc/letsencrypt/
sudo rm -rf /etc/nginx/
```

3. Re-install NGINX and Certbot

```bash
sudo apt-get install certbot
sudo apt-get install nginx
```

4. Navigate to NGINX HTTPS Setup directory and run tool

```bash
./setup_server.bash
```

<!-- - Obtain your certificate with Let's Encrypt and Certbot
  - sudo certbot certonly --standalone -d _SUBDOMAIN_._DOMAIN_._TOPLEVELDOMAIN_ -->
<!-- # Generated with Mozilla's SSL configuration site

#  -->

<!-- # read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1 -->
