# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 13/04/2019

# Load Energy groupings and dependencies
source("energy_groupings.R")

# View table data to confirm valud data. 
View(year_hourly_data_usage)

class(factor(year_hourly_data_usage$year))

# Change year to factor so graph understand it
year_hourly_data_usage$year <- factor(year_hourly_data_usage$year)

# Split data by year and display multiple graphs
ggplot(data=year_hourly_data_usage, aes(x=hour, y=mean_energy_usage)) +
    geom_line() +
    geom_point() + facet_wrap(~year)

# Function creates Line graph with hourly usage data.
line.chart <- function(dataFrame) {
  ggplot() + 
    geom_line(data = dataFrame, aes(x = hour, y = mean_energy_usage, color = year)) + 
    geom_point() +
    scale_x_continuous(breaks = 1:24) +
    ylab("Mwh (MegaWattHour)") +
    xlab("Hour")
}

# Breakdown of power usage compared with each other. 
line.chart(year_hourly_data_usage)

# Remove incomplete 2019 and 2013
year_hourly_data_usage_remove_outliers <- filter(year_hourly_data_usage, year != 2013)
year_hourly_data_usage_remove_outliers <- filter(year_hourly_data_usage, year != 2019)

# Graph without 2019 and 2013
line.chart(year_hourly_data_usage_remove_outliers)
