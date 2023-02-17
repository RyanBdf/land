#!/bin/bash

#-----------------------------------
# create folders
#-----------------------------------
if [ ! -d $(pwd)/data ]; then
  mkdir $(pwd)/data
fi

if [ ! -d $(pwd)/data/jenkins ]; then
  mkdir $(pwd)/data/jenkins
fi

if [ ! -d $(pwd)/data/mysql ]; then
  mkdir -p $(pwd)/data/mysql/5.6.29
fi

if [ ! -d $(pwd)/data/jenkins ]; then
  mkdir $(pwd)/data/jenkins
  #backups
  mkdir -p $(pwd)/data/jenkins/backups/land/files
  mkdir -p $(pwd)/data/jenkins/backups/land/db
fi

#-----------------------------------
# edit rights folder
#-----------------------------------
chown 1000 -R $(pwd)/data/jenkins

#-----------------------------------
# restart + clear logs
#-----------------------------------
docker-compose stop
truncate -s 0 /var/lib/docker/containers/*/*-json.log
docker-compose up --build -d
