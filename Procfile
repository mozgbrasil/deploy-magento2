web: $(composer config bin-dir)/heroku-php-apache2 -F php_fpm.conf -C apache_app.conf
worker: php worker.php 'bash -x app.sh release_host'
