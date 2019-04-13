# Title     : Test Analysis' about energy usage data
# Objective : TODO
# Created by: Daniel Devine
# Created on: 13/04/2019

# Function checks if package is installed

source("functions.R")

Packages <- c(
    "DBI",
    "tidyverse"
)

check.packages(Packages)

con <- load.energydb()

energy_data <- dbReadTable(con, "irish_energy_data")
names(energy_data)
energy_data$datetime <- lubridate::as_datetime(energy_data$datetime)

mean(energy_data$mwh)
energy_data_by_year <- group_by(energy_data, year)

tail(energy_data_by_year)

year_on_year_energy_usage <- summarize(energy_data_by_year, mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_on_year_energy_usage) <- c("Year", "Mwh")
class(year_on_year_energy_usage)
year_on_year_energy_usage

yearly_energy_usage_bar_plot <- ggplot(
  data=year_on_year_energy_usage, 
  aes(
    x=Year,
    y=Mwh,
    fill=Year
  )) +
    geom_bar(stat="identity")+
    geom_text(aes(label=Mwh, vjust=-0.2))+
    theme_minimal()

yearly_energy_usage_bar_plot
