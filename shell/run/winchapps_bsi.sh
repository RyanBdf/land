#!/bin/bash
title "Running $project_name"

cd projects/$project_name || exit

isRunning=$(docker ps -a -aqf name="$project_name")

if [ ! -z $isRunning ]; then
  docker kill "$project_name" && docker rm "$project_name"
fi

docker build -t "$project_name" --no-cache -f ./_build/docker/apache/Dockerfile .

apt-get update

#checkout files
#git checkout ./_build/docker/apache/Dockerfile
#git checkout ./_build/docker/apache/app_php.ini

docker run -d --name "$project_name" -p 8081:80 --network land_winchapps_net -v "/$(pwd)/:/var/www/basededonneesunique" --restart always "$project_name"
