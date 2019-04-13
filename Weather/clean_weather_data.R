# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 14/04/2019

source("../functions.R")

load_weather_data <- function(csv_file, selected_headers=c()) {
    weather_data <- read.csv(paste("raw_data/", sep = "",csv_file), header = TRUE)
    colnames(weather_data)
}

file_names <- c(
    "mace-head-daily.csv",
    "dublin-airport-daily.csv",
    "malin-head-daily.csv",
    "mount-dillon-daily.csv",
    "roaches-point-daily.csv"
)

for (file in file_names) {
    load_weather_data(file)
}

weather_data <- read.csv("raw_data/mace-head-daily.csv", header = TRUE)
colnames(weather_data)
selected_columns <- c("date", "maxtp")
stripped_weather_data <- weather_data