# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 14/04/2019

source("../functions.R")

weatherDB <- dbConnect(RSQLite::SQLite(), "weather_data.sqlite")

load_weather_data <- function(station, selected_columns=c()) {
    weather_data = read.csv(paste("raw_data/" ,station, "-daily.csv",  sep = ""), header = TRUE)
    weather_data$station = station
    stripped_weather_data = weather_data[selected_columns]
    stripped_weather_data
    stripped_weather_data$date = as.Date(stripped_weather_data$date, format="%d-%b-%Y")
    stripped_weather_data$year = as.integer(year(stripped_weather_data$date))
    stripped_weather_data$month = as.integer(month(stripped_weather_data$date))
    stripped_weather_data$day = as.integer(day(stripped_weather_data$date))
    stripped_weather_data$datestring = as.character(stripped_weather_data$date)
    dbWriteTable(weatherDB, "irish_weather_stations", stripped_weather_data, append = TRUE)
}

file_names <- c(
    "mace-head",
    "dublin-airport",
    "malin-head",
    "mount-dillon",
    "roches-point"
)
selected_columns <- c("date", "maxtp", "mintp", "rain", "wdsp", "evap", "soil", "station")

for (station in file_names) {
    load_weather_data(station, selected_columns)
}