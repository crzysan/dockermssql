# Overview

* Build a docker image based on mcr.microsoft.com/mssql/server
* Configure the database with a database and user

# How to Run
## Clone this repo
```
git clone https://github.com/crzysan/dockermssql.git
```

## From DockerHub

Pulling the image
```
docker pull crzysan/mssqldocker
```

## Building the image for the first time
```
docker build . -t crzysan/mssqldocker:2019-latest
```

## Run the container
```
docker run -d -p 1433:1433  crzysan/mssqldocker:2019-latest
docker run --name mssqldev -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Passw0rd" -e "MSSQL_DB=mydb" -e "MSSQL_USER=myuser" -e "MSSQL_PASSWORD=Mypass1"-p 8433:1433 -d crzysan/mssqldocker:2019-latest
```

## Connect to the container
```
docker exec -it mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD
```
