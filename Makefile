init: nginx_mysql users php_74_fpm

create_certbot:
	ansible-playbook -i hosts.yml create_certbot.yml

users:
	ansible-playbook -i hosts.yml create_users.yml

nginx_mysql:
	ansible-playbook -i hosts.yml nginx_mysql.yml

php_74_fpm:
	ansible-playbook -i hosts.yml install_php.yml



