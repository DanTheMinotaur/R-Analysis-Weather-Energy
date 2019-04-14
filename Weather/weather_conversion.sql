SELECT
       station,
       date,
       year,
       month,
       day,
       datestring,
       ROUND((maxtp + mintp) / 2, 2)  AS avgtemp, -- Convert for Average Temperature
       ROUND(wdsp * 1.852) AS wind_kmh, -- Convert Windspeed Knot to KMH
       rain,
       evap,
       soil
FROM irish_weather_stations;