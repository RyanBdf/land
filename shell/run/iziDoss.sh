#!/bin/bash
title "Running izidoss"

cd projects/$project_name || exit

isRunning=$(docker ps -a -aqf name="izidoss")

if [ ! -z $isRunning ]; then
  docker kill izidoss && docker rm izidoss
fi

#changing env variable
perl -pi -e 's/`opdv/`dev.opdv/g' ./_build/docker/apache/Dockerfile
# changing sendmail config
perl -pi -e 's/sendmail -i -t/sendmail -i -t --smtp-addr=mailhog:1025/g' ./_build/docker/apache/app_php.ini

docker build -t izidoss --no-cache -f ./_build/docker/apache/Dockerfile .

#Install pdftk
apt-get update
apt-get install pdftk

#checkout files
git checkout ./_build/docker/apache/Dockerfile
git checkout ./_build/docker/apache/app_php.ini

docker run -d --name izidoss -p 8081:80 --network land_default -v "/$(pwd)/:/var/www" --restart always izidoss
