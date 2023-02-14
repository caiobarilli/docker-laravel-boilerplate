#!/bin/bash

container_id=$(docker ps -qf "name=_web")

docker exec -it $container_id /bin/bash -c "
php artisan storage:link
chmod o+w ./storage/ -R
"
