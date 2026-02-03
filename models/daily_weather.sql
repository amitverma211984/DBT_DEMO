WITH daily_weather AS (

    SELECT 
    date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    FROM {{source('demo','weather')}}
),
daily_weather_agg AS (
   SELECT 
   daily_weather,
   weather,
   round(avg(temp),2) AS avg_temp,
   round(avg(pressure),2) AS avg_pressure,
   round(avg(humidity),2) AS avg_humidity,
   round(avg(clouds),2) AS avg_clouds
   FROM 
   daily_weather 
   GROUP BY daily_weather,
   weather

  qualify  ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY COUNT(weather) DESC) = 1
)

SELECT * 
FROM daily_weather_agg