# psql-client

A docker postgresql client

## Build

```
docker build --no-cache -t psql-client .
```

## Usage

### Environment variables

you can set these variables any way you like

```
dbhost=localhost
dbport=5432
dbname=postgres
dbuser=pguser
dbpass=pgpass
```

### Interactive

Create a postgres client container that we can use to connect to db servers

```
docker run -itd --network=host --name=pgclient psql-client
```

Query a db, using the running container

```
docker exec -it pgclient \
    psql postgresql://${dbuser}:${dbpass}@${dbhost}:${dbport}/${dbname} \
    -c 'select 1'
```

### Non Interactive

You can override the default entrypoint (/bin/sh) You can use the entrypoint option
to execute psql commands and volumes to load scripts that can be executed with the psql client.

The container will be created and removed after each run

```
docker run -it --rm \
    -v $(pwd)/query.sql:/query.sql \
    --network host  \
    --entrypoint psql \
    psql-client \
    postgresql://${dbuser}:${dbpass}@${dbhost}:${dbport}/${dbname} -a -f /query.sql
```

### Docker Compose

```
psql-client:
  image: psql-client:latest
  container_name: psql-client
  volumes:
    - ./scripts/query.sql:/query.sql
  entrypoint: psql postgresql://${dbuser}:${dbpass}@${dbhost}:${dbport}/${dbname} -a -f /query.sql
```