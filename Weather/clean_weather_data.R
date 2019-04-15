# Title     : Clean Weather Data
# Objective : To format Weather data from multiple csv files and insert into SQLite Database
# Created by: daniel
# Created on: 14/04/2019

# Load core functions and weather DB
source("./weather_functions.R")

# Function will create and format daily station weather from csv file
load_weather_data <- function(station, selected_columns=c()) {
    # Read CSV File
    weather_data = read.csv(paste("raw_data/" ,station, "-daily.csv",  sep = ""), header = TRUE)
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