docker run --name mongodb -p 27017:27017 -d mongo:4.4.1-bionic

docker exec -it mssql mkdir /var/opt/mssql/backup
docker cp shared/backup.bak mssql:/var/opt/mssql/backup

#
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "P@ssword1" -Q "RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/backup.bak'"

docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword1' -Q 'RESTORE DATABASE MercariDirectNightly FROM DISK = "/var/opt/mssql/backup/backup.bak" WITH MOVE "MercariDirectNightly" TO "/var/opt/mssql/data/MercariDirectNightly.mdf", MOVE "MercariDirectNightly_log" TO "/var/opt/mssql/data/MercariDirectNightly.ldf"'

#staging
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword1' -Q 'RESTORE DATABASE MercariDirectStaging FROM DISK = "/var/opt/mssql/backup/staging.bak" WITH MOVE "MercariDirectNightly" TO "/var/opt/mssql/data/MercariDirectStaging.mdf", MOVE "MercariDirectNightly_log" TO "/var/opt/mssql/data/MercariDirectStaging.ldf"'


docker run --name some-mongo -d mongo:tag