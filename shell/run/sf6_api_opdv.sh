#!/bin/bash
title "Running sf6_api_opdv"

cd projects/$project_name || exit

isRunning=$(docker ps -a -aqf name="sf6_api_opdv")

if [ ! -z $isRunning ]; then
  docker kill sf6_api_opdv && docker rm sf6_api_opdv
fi

#changing env variable
perl -pi -e 's/`api./`dev.api./g' ./_build/docker/php-apache/Dockerfile

docker build -t sf6_api_opdv --no-cache -f ./_build/docker/php-apache/Dockerfile .

#checkout the file
git checkout ./_build/docker/php-apache/Dockerfile

docker run -d --name sf6_api_opdv -p 8083:80 --network land_default -v "/$(pwd)/:/var/www/html" --restart always sf6_api_opdv
