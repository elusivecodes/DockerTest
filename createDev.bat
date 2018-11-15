@echo off

set apacheContainer=frostapache
set phpContainer=frostphp
set networkName=frostnet

set port=8000

set siteDir=%CD%\..\Site
set appDir=%siteDir%\App
set staticDir=%siteDir%\Static

for /F %%G IN ('docker ps -a --filter "name=%apacheContainer%|%phpContainer%" --format "{{.Names}}"') DO (
    echo Removing %%G container..
    docker rm -f %%G
)

for /F %%G in ('docker network ls --filter "name=%networkName%" --format "{{.Name}}"') do (
    echo Removing %%G network..
    docker network rm %%G
)

pushd 00-apache
echo Building apache image..
docker build -t apache .
popd

pushd 01-php
echo Building php image..
docker build -t php .
popd

echo Creating network..
docker network create --driver bridge %networkName%

echo Creating apache container..
docker run -d -p %port%:80 -v "%staticDir%:/var/www/public" --name %apacheContainer% --network %networkName% apache

echo Creating php container..
docker run -d -v "%appDir%:/var/www" --name %phpContainer% --network %networkName% php