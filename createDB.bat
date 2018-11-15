@echo off

set dbContainer=frostdb

for /F %%G IN ('docker ps -a --filter "name=%dbContainer%" --format "{{.Names}}"') DO (
    echo Removing %%G container..
    docker rm -f %%G
)

echo Creating mariadb container..
docker run -d -p 3306:3306 --name %dbContainer% -e MYSQL_ROOT_PASSWORD=mypassword mariadb:latest