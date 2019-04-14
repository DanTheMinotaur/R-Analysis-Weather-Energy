# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 14/04/2019

source("../functions.R")

weather_data <- load.weatherdb(5)
View(weather_data)
colnames(weather_data)

weather_monthly_average_temp <- summarize(group_by(weather_data, year, month), mean_temp = round(mean(temp, na.rm = TRUE), 2))
View(weather_monthly_average_temp)