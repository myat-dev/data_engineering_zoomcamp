# Homework 01-docker-terraform

### Q1. Understanding docker first run
Run docker with the python:3.12.8 image in an interactive mode, use the entrypoint bash.

What's the version of pip in the image? \
*Dockerfile*
```
FROM python:3.12.8

RUN pip install pandas

ENTRYPOINT ["bash"]
```

*Docker build*
```
docker build -t homework1 .
```
*Docker run and check pip version*
```
docker run -it homework1
root# pip -V
```
Answer: `24.3.1`

### Q2. Understanding Docker networking and docker-compose
pgadmin should use `db:5432` to connect to postgres db.

### Q3. Trip Segmentation Count

During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, respectively, happened:

- Up to 1 mile
- In between 1 (exclusive) and 3 miles (inclusive),
- In between 3 (exclusive) and 7 miles (inclusive),
- In between 7 (exclusive) and 10 miles (inclusive),
- Over 10 miles
```
SELECT 
	SUM(CASE
			WHEN trip_distance <= 1 THEN 1
            ELSE 0
		END) AS trips_up_to_1_mile,
	SUM(CASE 
            WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1
            ELSE 0
        END) AS trips_between_1_and_3_miles,
	SUM(CASE 
            WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1
            ELSE 0
        END) AS trips_between_3_and_7_miles,
	SUM(CASE 
            WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1
            ELSE 0
        END) AS trips_between_7_and_10_miles,
    SUM(CASE 
            WHEN trip_distance > 10 THEN 1
            ELSE 0
        END) AS trips_over_10_miles
FROM green_taxi_data t
WHERE t."lpep_pickup_datetime" >= '2019-10-01'
AND t."lpep_dropoff_datetime" < '2019-11-01'
```
Answer: `104,802; 198,924; 109,603; 27,678; 35,189`

### Q4. Longest trip for each day
Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.

Tip: For every day, we only care about one single trip with the longest distance.

- 2019-10-11
- 2019-10-24
- 2019-10-26
- 2019-10-31
```
WITH daily_longest_trip AS(
	SELECT
		DATE(t."lpep_pickup_datetime") AS pickup_day,
		MAX(t."trip_distance") AS max_trip_distance
	FROM green_taxi_data as t
	GROUP BY Date(t."lpep_pickup_datetime")
)
SELECT 
	pickup_day,
	max_trip_distance
FROM daily_longest_trip
ORDER BY max_trip_distance DESC
LIMIT 1;
```
Answer: `2019-10-31`

### Q5. Three biggest pickup zones

Which were the top pickup locations with over 13,000 in total_amount (across all trips) for 2019-10-18?

Consider only lpep_pickup_datetime when filtering by date.

- East Harlem North, East Harlem South, Morningside Heights
- East Harlem North, Morningside Heights
- Morningside Heights, Astoria Park, East Harlem South
- Bedford, East Harlem North, Astoria Park
```
SELECT
	t."PULocationID",
	z."Zone" AS pickup_zone,
	SUM(total_amount) AS total_amount_sum
FROM green_taxi_data t
JOIN zones z
	ON t."PULocationID" = z."LocationID"
WHERE DATE(t."lpep_pickup_datetime") = '2019-10-18'
GROUP BY t."PULocationID", z."Zone"
HAVING SUM(t.total_amount) > 13000
ORDER BY total_amount_sum DESC;
```
Answer:  `East Harlem North, East Harlem South, Morningside Heights`

### Q6. Largest tip
For the passengers picked up in October 2019 in the zone named "East Harlem North" which was the drop off zone that had the largest tip?

Note: it's tip , not trip

We need the name of the zone, not the ID.

- Yorkville West
- JFK Airport
- East Harlem North
- East Harlem South

```
SELECT
	z_do."Zone" AS dropoff_zone,
	MAX(t."tip_amount") AS largest_tip
FROM green_taxi_data t
JOIN zones z_pu
	ON t."PULocationID" = z_pu."LocationID"
JOIN zones z_do
	ON t."DOLocationID" = z_do."LocationID"
WHERE z_pu."Zone" = 'East Harlem North'
	AND DATE(t."lpep_pickup_datetime") BETWEEN '2019-10-01' AND '2019-10-31'
GROUP BY z_do."Zone"
ORDER BY largest_tip DESC
LIMIT 1;
```
Answer: `JFK Airport`

### Q7. Terraform Workflow
Which of the following sequences, respectively, describes the workflow for:

- Downloading the provider plugins and setting up backend,
- Generating proposed changes and auto-executing the plan
- Remove all resources managed by terraform`

Answers:

- terraform import, terraform apply -y, terraform destroy
- teraform init, terraform plan -auto-apply, terraform rm
- terraform init, terraform run -auto-approve, terraform destroy
- terraform init, terraform apply -auto-approve, terraform destroy
- terraform import, terraform apply -y, terraform rm

Answer: `terraform init, terraform apply -auto-approve, terraform destroy`