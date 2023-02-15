#!/bin/bash
title "Running winchapps_bsi"

cd projects/$project_name || exit

isRunning=$(docker ps -a -aqf name="winchapps_bsi")

if [ ! -z $isRunning ]; then
  docker kill winchapps_bsi && docker rm winchapps_bsi
fi

#changing env variable
#perl -pi -e 's/`opdv/`dev.opdv/g' ./_build/docker/apache/Dockerfile
# changing sendmail config
#perl -pi -e 's/sendmail -i -t/sendmail -i -t --smtp-addr=mailhog:1025/g' ./_build/docker/apache/app_php.ini

docker build -t winchapps_bsi --no-cache -f ./_build/docker/apache/Dockerfile .

#Install pdftk
apt-get update
apt-get install pdftk

#checkout files
git checkout ./_build/docker/apache/Dockerfile
git checkout ./_build/docker/apache/app_php.ini

docker run -d --name winchapps_bsi -p 8081:80 --network land_default -v "/$(pwd)/:/var/www" --restart always winchapps_bsi
