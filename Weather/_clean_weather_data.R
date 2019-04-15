# Title     : Clean Weather Data
# Objective : To format Weather data from multiple csv files and insert into SQLite Database
# Created by: daniel
# Created on: 14/04/2019

# Load core functions and weather DB
source("../functions.R")
weatherDB <- dbConnect(RSQLite::SQLite(), "weather_data.sqlite")

# Function will create and format daily station weather from csv file
load_weather_data <- function(station, selected_columns=c()) {
    # Read CSV File
    weather_data = read.csv(paste("data/" ,station, "-daily.csv",  sep = ""), header = TRUE)
    # Assign Station name
    weather_data$station = station
    # Select specific columns
    stripped_weather_data = weather_data[selected_columns]
    # Format date as Date Object
    stripped_weather_data$date = as.Date(stripped_weather_data$date, format="%d-%b-%Y")
    # Assign date info to own columns
    stripped_weather_data$year = as.integer(year(stripped_weather_data$date))
    stripped_weather_data$month = as.integer(month(stripped_weather_data$date))
    stripped_weather_data$day = as.integer(day(stripped_weather_data$date))
    # Create a string of date
    stripped_weather_data$datestring = as.character(stripped_weather_data$date)
    # Append to Weather DB table
    dbWriteTable(weatherDB, "irish_weather_stations", stripped_weather_data, append = TRUE)
}

# List of file names for data
file_names <- c(
    "mace-head",
    "dublin-airport",
    "malin-head",
    "mount-dillon",
    "roches-point"
)
# Columns for database
selected_columns <- c("date", "maxtp", "mintp", "rain", "wdsp", "evap", "soil", "station")

# Loop through csv file and add to DB
for (station in file_names) {
    load_weather_data(station, selected_columns)
}

# Query DB and get average betweeen each weather station
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

