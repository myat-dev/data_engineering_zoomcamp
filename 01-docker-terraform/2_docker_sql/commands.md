
## python script
```
python ingest_data.py `
    --user=root `
    --password=root `
    --host=localhost `
    --port=5432 `
    --db=ny_taxi `
    --table_name=yellow_taxi_trips `
    --url="C:\Myat\DataEngineering\data_engineering_zoomcamp\01-docker-terraform\2_docker_sql\yellow_tripdata_2021-01.csv"
```

## Postgres sql database docker run
```
  docker run -it `
  -e POSTGRES_USER="root" `
  -e POSTGRES_PASSWORD="root" `
  -e POSTGRES_DB="ny_taxi" `
  -v C:\Myat\DataEngineering\data_engineering_zoomcamp\01-docker-terraform\2_docker_sql\ny_taxi_postgres_data:/var/lib/postgresql/data `
  -p 5432:5432 `
  --network=pg-network `
  --name pg-database `
  postgres:13
```

## Pgadmin docker run
```
docker run -it `
  --network=pg-network `
  taxi_ingest:v001 --user=root `
  --password=root `
  --host=pg-database `
  --port=5432 `
  --db=ny_taxi `
  --table_name=yellow_taxi_trips `
  --url="./yellow_tripdata_2021-01.csv"
```

## Run data ingestion Python script from docker
```
docker run -it `
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" `
  -e PGADMIN_DEFAULT_PASSWORD="root" `
  -p 8080:80 `
  --network=pg-network `
  --name pgadmin-2 `
  dpage/pgadmin4
```