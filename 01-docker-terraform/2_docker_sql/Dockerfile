FROM python:3.9

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY yellow_tripdata_2021-01.csv yellow_tripdata_2021-01.csv
COPY ingest_data.py ingest_data.py

ENTRYPOINT ["python", "ingest_data.py"]