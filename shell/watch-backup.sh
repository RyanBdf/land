#!/bin/bash
. <(cat /home/land/shell/source/*)
path_backups=/home/land/data/jenkins/backups
#----------------------FTP Settings--------------------#
FTPHOST=ftpback-rbx2-167.ovh.net
FTPUSER=ns31127528.ip-51-91-30.eu
FTPPASS=QV4T6VumYt
LFTP=$(which lftp)
#-------------------Deletion Settings-------------------#
DAYS=5                                   # how many days of backups do you want to keep?
RMDATE=$(date --iso -d $DAYS' days ago') # TODAY minus X days - too old files

inotifywait -m -r ${path_backups} -e moved_to -e close_write |
  while read path action file; do
    if [[ "$file" =~ .*gz$ || "$file" =~ .*sql$ ]]; then
      #send to ftp
      #lftp -e "put -O land/$(basename $path) ${path}${file}; bye" -u ns31127528.ip-51-91-30.eu,EymgMurCWb ftpback-rbx2-167.ovh.net
      project=$(dirname $path)
      $LFTP <<EOF
          open ${FTPUSER}:${FTPPASS}@${FTPHOST}
          cd $(basename $project)/$(basename $path)
          echo ${path}${file}
          mput -E ${path}${file}
          rm -rf dump_$RMDATE.sql
          rm -rf $RMDATE.tar.gz
          bye
EOF
    fi
  done
