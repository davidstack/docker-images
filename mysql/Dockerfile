FROM mysql:5.7

COPY files /opt/sql 
RUN chmod 750 /opt/sql -R
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
exec "$@"