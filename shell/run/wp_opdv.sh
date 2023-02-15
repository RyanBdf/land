#!/bin/bash
title "Running wordpress opdv"

cd projects/$project_name || exit

isRunning=$(docker ps -a -aqf name="wp_opdv")

if [ ! -z $isRunning ]; then
  docker kill wp_opdv && docker rm wp_opdv
fi

#changing env variable
perl -pi -e 's/`opretdevous/`dev.opretdevous/g' ./_build/docker/Dockerfile

docker build -t wp_opdv --no-cache -f ./_build/docker/Dockerfile .

#checkout files
git checkout ./_build/docker/Dockerfile

docker run -d --name wp_opdv -p 8082:80 --network land_default \
       -v "/$(pwd)/themes:/var/www/html/wp-content/themes" \
       -v "/$(pwd)/plugins:/var/www/html/wp-content/plugins" \
       -v "/$(pwd)/uploads:/var/www/html/wp-content/uploads" \
       --restart always wp_opdv
