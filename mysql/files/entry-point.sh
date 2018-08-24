#!/bin/bash
bash /docker-entrypoint.sh
echo "start mysql in backend"
nohup mysqld>>/var/log/mysql.log &
bash /usr/local/bin/entry-point.sh
while true do
   sleep 1m
done
