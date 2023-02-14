#!/bin/bash

container_id=$(docker ps -qf "name=_web")

docker exec -it $container_id /bin/bash
