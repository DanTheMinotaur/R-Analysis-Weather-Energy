# Title     : Graph Weather Data
# Objective : See any interesting information from weather data.
# Created by: Daniel Devine
# Created on: 14/04/2019

source("./weather_groupings.R")



weather_daily_average <- filter(weather_daily_average, year != 2008)
weather_daily_average <- filter(weather_daily_average, year != 2019)
weather_daily_average$date <- as.Date(weather_daily_average$datestring, format = "%Y-%m-%d")

# Remove Incomplete weather data
weather_yearly_average <- filter(weather_yearly_average, year != 2008)
weather_yearly_average <- filter(weather_yearly_average, year != 2019)

# Create point plot showing the average wind speed against the average temperate
ggplot(weather_yearly_average, aes(wind_kmh, temp, color = year, label=year)) +  
  geom_point() +
  geom_text(aes(label=year),hjust=0.1, vjust=1.4)

weather_daily_average

ggplot(weather_daily_average, aes(x = date, y = temp)) +
  geom_line(aes(color = temp)) + 
  # use date_breaks to have more frequent labels
  scale_x_date(date_breaks = "4 months") +
  # rotate x-axis labels
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))