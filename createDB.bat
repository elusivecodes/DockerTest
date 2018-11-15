@echo off

set dbContainer=frostdb

set user=frostdb
set password=mypassword

set port=8001

for /F %%G IN ('docker ps -a --filter "name=%dbContainer%" --format "{{.Names}}"') DO (
    echo Removing %%G container..
    docker rm -f %%G
)

echo Creating mariadb container..
docker run -d -p %port%:3306 --name %dbContainer% -e MYSQL_USER=%user% -e MYSQL_PASSWORD=%password% -e MYSQL_RANDOM_ROOT_PASSWORD=yes mariadb:latest