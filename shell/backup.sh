#!/bin/bash
path=/home/land/data/jenkins/backups
. <(cat /home/land/shell/source/*)

if [[ $1 == "db" ]]; then
  # dump of gogs-db container
  echo "docker is saving the db, please wait..."
  docker exec -t land_gogs_db pg_dumpall -c -U gogs >${path}/land/db/dump_$(date +%y-%m-%d).sql
  #dump iziDoss db
  docker exec land_mysql /usr/bin/mysqldump -u root --password=hbJPDHcpjk1993* iziDoss >${path}/mysql/iziDoss/dump_$(date +%y-%m-%d).sql
elif [[ $1 == "files" ]]; then
  # tar the entire folder land
  echo "a tar is compiling, please wait..."
  tar -cpzf ${path}/land/files/$(date +"%y-%m-%d").tar.gz --absolute-names --exclude='/home/land/.idea' --warning=no-file-changed /home/land
  success $(date +"%y-%m-%d").tar.gz
else
  fail "Type of backup is undefined"
  exit
fi
