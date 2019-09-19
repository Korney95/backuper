#!/bin/sh
#OLD VERSION
email=your@email.com
container_id=$(docker ps | grep postgres |  awk '{printf $1"\n"}')
date=`date +%Y-%m-%d-%H-%M`
name=dump_$date.gz
file=file_$date.tar.gz
backup_dir=backups/DB/
backup_files=backups/FILES
backup_good_log=$backup_dir/$date.good_pg.log
backup_bad_log=$backup_dir/$date.bad_pg.log
########################PGDUMP###########################################################
docker exec -i $container_id pg_dump -v  postgres -U postgres  | gzip > $backup_dir$name
########################LOG FILE#########################################################
SIZE=$(du -sb $backup_dir$name | awk '{ print $1 }')
if ((SIZE<10000)) ; then 
    echo $date "Dump database not created!" >>  $backup_bad_log
    sendmail $email  < $backup_bad_log	
else 
    echo $date "Dump database is created!" >> $backup_good_log 
    find $backup_dir -name "*.dump*.gz" -mtime +7 -type f -delete 
fi
tar -cvzf $backup_files/$file web 
find $backup_files -name "*.tar.gz" -mtime +7 -type f -delete
exit 0
