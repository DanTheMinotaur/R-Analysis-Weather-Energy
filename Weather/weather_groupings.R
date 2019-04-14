# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 14/04/2019

source("../functions.R")

weather_data <- load.weatherdb(5)
View(weather_data)
colnames(weather_data)

# Group By Month 
weather_monthly_average <- summarize_each(group_by(weather_data, year, month), fun=mean, temp, wind_kmh, rain, evap, soil)
View(weather_monthly_average)

# Group By Day
weather_daily_average <- summarize_each(group_by(weather_data, year, month, day), fun=mean, temp, wind_kmh, rain, evap, soil)
View(weather_daily_average)

# Group By Year
weather_yearly_average <- summarize_each(group_by(weather_data, year), fun=mean, temp, wind_kmh, rain, evap, soil)
View(weather_yearly_average)
