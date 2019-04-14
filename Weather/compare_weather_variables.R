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

View(weather_yearly_average)

ggplot(weather_yearly_average, aes(x = temp)) + 
  geom_density(col = NA, alpha(0.35))

# Display all data by year
line.alldata.by_year <- function(selected_year, datapoints = c("temp")) {
    chart_title = paste("Air Temperature, Windspeed, Rain Levels, Evaporation Levels and Soil Temperature for ", selected_year, sep=" ")
    year_weather = filter(weather_daily_average, year == selected_year)
    ggplot(year_weather, aes(x = date)) +
      geom_line(aes(y = temp, color = "temp")) + 
      geom_line(aes(y = wind_kmh, color = "wind_kmh")) + 
      geom_line(aes(y = rain, color = "rain")) + 
      geom_line(aes(y = evap, color = "evap")) + 
      geom_line(aes(y = soil, color = "soil")) + 
      scale_color_discrete(name = "Weather Data", labels = c("Temperature (Celcius)", "Wind Speed (Kmh)", "Rain (mm)", "Evaporation (mm)", "Soil Temp (Celcius)")) +
      # use date_breaks to have more frequent labels
      scale_x_date(date_breaks = "1 months", date_labels = "%b") +
      # rotate x-axis labels
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) + 
      xlab("Month") +
      ylab("Level") +
      ggtitle(chart_title)
}
line.alldata.by_year(2013)

# Function Creates Graph displaying Air and Soil Temp compared against each other for a year
line.temp.by_year <- function(selected_year) {
  chart_title = paste("Air Temperature and Soil Temperature for ", selected_year, sep=" ")
  year_weather = filter(weather_daily_average, year == selected_year)
  ggplot(year_weather, aes(x = date)) +
    geom_line(aes(y = temp, color = "temp")) + 
    geom_line(aes(y = soil, color = "soil")) + 
    scale_color_discrete(name = "Temperature Data", labels = c("Temperature (Celcius)", "Soil Temp (Celcius)")) +
    # use date_breaks to have more frequent labels
    scale_x_date(date_breaks = "1 months", date_labels = "%b") +
    # rotate x-axis labels
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) + 
    xlab("Month") +
    ylab("Degrees Celcius") +
    ggtitle(chart_title)
}
line.temp.by_year(2013)

# Function Creates Graph displaying Air and Soil Temp for all years
line.temp.all_years <- function() {
  chart_title = "Air Temperature and Soil Temperature from 2009 to 2018 "
  ggplot(weather_daily_average, aes(x = date)) +
    geom_line(aes(y = temp, color = "temp")) + 
    geom_line(aes(y = soil, color = "soil")) + 
    scale_color_discrete(name = "Temperature Data", labels = c("Temperature (Celcius)", "Soil Temp (Celcius)")) +
    # use date_breaks to have more frequent labels
    scale_x_date(date_breaks = "1 years", date_labels = "%Y") +
    # rotate x-axis labels
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) + 
    xlab("Year") +
    ylab("Degrees Celcius") +
    ggtitle(chart_title)
}
line.temp.all_years()

# Function compares Rain and Temperature Levels 
line.temp_evap.by_year <- function(selected_year, datapoints = c("temp")) {
  chart_title = paste("Air Temperature and Rain Levels for", selected_year, sep=" ")
  year_weather = filter(weather_daily_average, year == selected_year)
  ggplot(year_weather, aes(x = date)) +
    geom_line(aes(y = temp, color = "temp")) + 
    geom_line(aes(y = evap, color = "evap")) + 
    scale_color_discrete(name = "Weather Data", labels = c("Temperature (Celcius)", "Rain (mm)")) +
    # use date_breaks to have more frequent labels
    scale_x_date(date_breaks = "1 months", date_labels = "%b") +
    # rotate x-axis labels
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) + 
    xlab("Month") +
    ylab("Level") +
    ggtitle(chart_title)
}
line.temp_evap.by_year(2017)





