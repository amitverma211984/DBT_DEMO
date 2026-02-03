WITH BIKE AS (

    SELECT 
    DISTINCT
    start_statio_id,
    start_station_name,
    start_lat,
    start_lng
    FROM {{ ref('stage_bike') }}
    WHERE RIDE_ID != 'ride_id'

)
SELECT
*
FROM BIKE