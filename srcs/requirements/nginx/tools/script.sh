#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt -subj "/C=KR/L=Seoul/O=42/OU=Development/CN=$DOMAIN_NAME"

echo "
server
{
	listen 443 ssl;
	ssl_protocols  TLSv1.3;

	ssl_certificate /etc/ssl/certs/server.crt;
	ssl_certificate_key /etc/ssl/private/server_pkey.pem;

	root /var/www/html;
	index index.php index.html index.htm;
	server_name $DOMAIN_NAME;
	"  >  /etc/nginx/sites-available/default
echo '
	location / {
		try_files $uri $uri/ =404;
	}
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;

		fastcgi_param SCRIPT_FILENAME /var/www/html/$fastcgi_script_name;
		fastcgi_pass my_wordpress:9000;
	}
} ' >>  /etc/nginx/sites-available/default

nginx -g "daemon off;"