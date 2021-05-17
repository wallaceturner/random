docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=P@ssword1' -p 1433:1433 -d -v sqldata:/var/opt/mssql mcr.microsoft.com/mssql/server:2017-latest 
#to restart automatically (e.g. on boot)
docker update --restart=always <container id>
docker exec -it mssql mkdir /var/opt/mssql/backup
docker cp shared/backup.bak mssql:/var/opt/mssql/backup

#
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "P@ssword1" -Q "RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/backup.bak'"

docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword1' -Q 'RESTORE DATABASE MercariDirectNightly FROM DISK = "/var/opt/mssql/backup/backup.bak" WITH MOVE "MercariDirectNightly" TO "/var/opt/mssql/data/MercariDirectNightly.mdf", MOVE "MercariDirectNightly_log" TO "/var/opt/mssql/data/MercariDirectNightly.ldf"'

#staging
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword1' -Q 'RESTORE DATABASE MercariDirectStaging FROM DISK = "/var/opt/mssql/backup/staging.bak" WITH MOVE "MercariDirectNightly" TO "/var/opt/mssql/data/MercariDirectStaging.mdf", MOVE "MercariDirectNightly_log" TO "/var/opt/mssql/data/MercariDirectStaging.ldf"'

docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword1' -Q 'RESTORE DATABASE MercariIM FROM DISK = "/var/opt/mssql/backup/backup.bak" WITH MOVE "MercariIM" TO "/var/opt/mssql/data/IntRateLive.mdf", MOVE "MercariIM_log" TO "/var/opt/mssql/data/IntRateLive.ldf"'

docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'P@ssword1' -Q 'RESTORE DATABASE MercariDirectNightly FROM DISK = "/var/opt/mssql/backup/backup.bak" WITH MOVE "MercariDirectNightly" TO "/var/opt/mssql/data/MercariDirectNightly.mdf", MOVE "MercariDirectNightly_log" TO "/var/opt/mssql/data/MercariDirectNightly.ldf"'