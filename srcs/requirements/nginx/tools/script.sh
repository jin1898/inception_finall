#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $KEY_PATH \
		-out $CERTIFICAT_PATH \
		-subj "/C=KR/L=Seoul/O=42/OU=Development/CN=$DOMAIN_NAME"

echo "
server
{
	listen 443 ssl; # nginx가 443포트로만 듣도록 설정
	ssl_protocols  TLSv1.3; # ssl인증서의 상위 버전인 TLS1.3을 사용하도록함. 

	ssl_certificate $CERTIFICAT_PATH;
	ssl_certificate_key $KEY_PATH;

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

nginx -g "daemon off;" #포그라운드로 설정