#!/bin/bash
function createDataBase(){
	HOSTNAME="127.0.0.1"                                       
	PORT="3306"  
	USERNAME="root"  
    PASSWORD="mysql" 
	MYSQL_CMD="mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD}"   
	DBNAME=$1     
	echo ${MYSQL_CMD}
	echo "drop database ${DBNAME} first"  
	drop_db_sql="drop database IF EXISTS ${DBNAME}"  
	echo ${drop_db_sql}  | ${MYSQL_CMD}                        
	if [ $? -ne 0 ]                                                                               
	then  
	 echo "drop databases ${DBNAME} failed ..."  
	 exit 1  
	fi 
	
   #create
	echo "create database ${DBNAME}"  
	create_db_sql="create database IF NOT EXISTS ${DBNAME} DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci"  
	echo ${create_db_sql}  | ${MYSQL_CMD}                                 
	if [ $? -ne 0 ]                                                                                
	then  
	 echo "create databases ${DBNAME} failed ..."  
	 exit 1  
	fi   
}

function createUser(){
	HOSTNAME="127.0.0.1"                                       
	PORT="3306"  
	USERNAME="root"  
	PASSWORD="mysql"
	MYSQL_CMD="mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD}"   
	DBNAME=$1 
	echo ${MYSQL_CMD}
	echo "create user $1"
	grant_sql1="grant all privileges on *.* to $1@'%'  identified by '$2'"
	grant_sql2="grant all privileges on *.* to $1@'localhost'  identified by '$2'"
	echo ${grant_sql1}  | ${MYSQL_CMD}                                  
	if [ $? -ne 0 ]                                                                              
	then
	 echo "create user $1 failed ..."
	 exit 1
	fi 
	echo ${grant_sql2}  | ${MYSQL_CMD}                                  
	if [ $? -ne 0 ]                                                                              
	then
	 echo "create user $1 failed 2..."
	 exit 1
	fi 
}

function importData(){
	HOSTNAME="127.0.0.1"                                       
	PORT="3306"  
	USERNAME="root"  
	PASSWORD="mysql" 
	DBNAME=$1
	SQL_FILE_NAME=$2
	MYSQL_CMD="mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} -D${DBNAME}"   
	echo ${MYSQL_CMD}
    echo "source ${SQL_FILE_NAME}"

}
chown -R mysql:mysql /docker-entrypoint-initdb.d/ -R
echo "create user fm"
createUser fm fm
echo "create user email"
createUser email email
echo "create database dm"
createDataBase dm
echo "create database fei"
createDataBase fei
echo "create database meta"
createDataBase meta
echo "create database pbt"
createDataBase pbt
echo "create database zabbix"
createDataBase zabbix

echo "create database turbomail"
createDataBase turbomail

#move sql files
echo "import sql for  database dm"
importData dm /docker-entrypoint-initdb.d/sql/dm.sql
echo "import sql for  database meta"
importData meta /docker-entrypoint-initdb.d/sql/meta.sql
echo "import sql for  database fei"
importData fei /docker-entrypoint-initdb.d/sql/fei.sql
echo "import sql for  database turbomail"
importData turbomail /docker-entrypoint-initdb.d/sql/turbomail.sql
echo "import sql for  database zabbix"
importData zabbix /docker-entrypoint-initdb.d/sql/zabbix.sql

