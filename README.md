# NGINX-HTTPS-Setup

## NGINX

### Config file location on machine

/etc/nginx/conf.d/_SUBDOMAIN_._DOMAIN_._TOPLEVELDOMAIN_.conf

- make sure to first obtain your certificate with Let's Encrypt and Certbot
  - sudo certbot certonly --standalone -d _SUBDOMAIN_._DOMAIN_._TOPLEVELDOMAIN_
- If you don't have Certbot or NGINX on your system, and you're running Ubuntu:
  - sudo apt-get install certbot
  - sudo apt-get install nginx
- Kill any processes running on port 80:
  - sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill

<!-- # Generated with Mozilla's SSL configuration site

# generated 2020-09-04, Mozilla Guideline v5.6, nginx 1.14.0, OpenSSL 1.1.1, modern configuration

# https://ssl-config.mozilla.org/#server=nginx&version=1.14.0&config=modern&openssl=1.1.1&guideline=5.6 -->
