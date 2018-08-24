#!/bin/bash
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
echo $limit_in_bytes
# If not default limit_in_bytes in cgroup
if [ "$limit_in_bytes" -ne "9223372036854771712" ]
then
        limit_in_megabytes=`expr ${limit_in_bytes} / 1048576`
        echo $limit_in_megabytes
        heap_size=$limit_in_megabytes
        export JAVA_OPTS="-Xms${heap_size}m -Xmx${heap_size}m $JAVA_OPTS"
fi
exec /opt/tomcat/bin/catalina.sh run

