#!/usr/bin/env bash

str=$1
container_id=$(docker ps -qf "name=_web")

# Bash do container
if [ "$str" = "bash" ]; then
    docker exec -it $container_id /bin/bash
fi

# Instala o Laravel
if [ "$str" = "install" ]; then
    docker exec -it $container_id /bin/bash -c "
    composer create-project laravel/laravel laravel
    "

    docker exec -it $container_id /bin/bash -c "
    cd ./laravel
    mv .editorconfig /var/www/html
    mv .env /var/www/html
    mv .env.example /var/www/html
    mv .gitattributes /var/www/html
    mv .gitignore /var/www/html
    mv * /var/www/html
    rm -rf /var/www/html/laravel
    "
fi

# Instala o Lumen
if [ "$str" = "lumen" ]; then
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
fi

# Permissões do do container
if [ "$str" = "permissions" ]; then
    docker exec -it $container_id /bin/bash -c "
    php artisan storage:link
    chown -R 1000:1000 ./
    chmod o+w ./storage/ -R
    "
fi