#!/bin/bash

container_id=$(docker ps -qf "name=_web")

docker exec -it $container_id /bin/bash -c "
composer create-project --prefer-dist laravel/lumen lumen
"

docker exec -it $container_id /bin/bash -c "
cd ./lumen
mv .editorconfig /var/www/html
mv .env /var/www/html
mv .env.example /var/www/html
mv .gitignore /var/www/html
mv .styleci.yml /var/www/html
mv * /var/www/html
rm -rf /var/www/html/lumen
"
