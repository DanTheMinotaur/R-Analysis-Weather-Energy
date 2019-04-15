# Title     : Join Weather Data
# Objective : Initial Weather Data is split between multiple stations, this script is create averate values
# Created by: daniel
# Created on: 14/04/2019

# Load core functions and weather DB
source("./weather_functions.R")

# Query Database and convert values
query_result <- dbSendQuery(weatherDB,
"SELECT
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
FROM irish_weather_stations;")
# Fetch data
weather_station_data <- dbFetch(query_result)
# print head for validation
head(weather_station_data)

# Combine weather station data by year month and day and average the values 
weather_avg <- summarize(group_by(weather_station_data, year, month, day, datestring),
temp = round(mean(avgtemp, na.rm = TRUE), 2),
wind_kmh = round(mean(wind_kmh, na.rm = TRUE), 2),
rain = round(mean(rain, na.rm = TRUE), 2),
evap = round(mean(evap, na.rm = TRUE), 2),
soil = round(mean(soil, na.rm = TRUE), 2),
accuracy = n() # Integer value stating number of stations that resulted in value
)
head(weather_avg)
tail(weather_avg)

# Write Data to SQL Database table
dbWriteTable(weatherDB, "irish_average_weather", weather_avg)

