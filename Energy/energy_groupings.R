# Title     : Create groupings of energy_data from eirgide
# Objective : group data in meaningful ways for data visualisations
# Created by: Daniel Devine
# Created on: 13/04/2019

source("..functions.R")

# Load energy data from DB
energy_data <- load.energydb()

# Group Energy data by times, broken down into further subtimes for month, day, hours
year_month_energy_usage <- summarize(group_by(energy_data, year, month), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_month_energy_usage) <- c("Year", "Month", "Mwh")
year_month_day_energy_usage <- summarize(group_by(energy_data, year, month, day), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_month_day_energy_usage) <- c("Year", "Month", "Day", "Mwh")
year_month_day_hour_energy_usage <- summarize(group_by(energy_data, year, month, day, hour), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_month_day_hour_energy_usage) <- c("Year", "Month", "Day", "Hour", "Mwh")
year_hourly_data_usage <- summarize(group_by(energy_data, year, hour), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_month_day_hour_energy_usage) <- c("Year", "Hour", "Mwh")
year_daily_data_usage <- summarize(group_by(energy_data, year, day), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_month_day_hour_energy_usage) <- c("Year", "Day", "Mwh")

year_month_energy_usage
year_month_day_energy_usage
year_month_day_hour_energy_usage
year_hourly_data_usage
year_daily_data_usage