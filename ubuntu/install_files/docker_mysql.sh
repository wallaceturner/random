
docker run --name mysql  -v /opt/mysql:/etc/mysql/conf.d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=P@ssword1 -d mysql:5.7.31 mysqld --lower_case_table_names=1
# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i mysql /usr/bin/mysql -u root --password=root etool
docker exec -i mysql mysqladmin -u root -p variables




#docker rm mysql --force
#docker exec -i mysql mysqladmin -u root -p variables | grep lower_case_table_names