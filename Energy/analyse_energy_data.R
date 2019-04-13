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
#install.packages(Packages)

#lapply(Packages, library, character.only = TRUE)

con <- dbConnect(RSQLite::SQLite(), "energy_data.sqlite")

energy_data <- dbReadTable(con, "irish_energy_data")
names(energy_data)
energy_data$datetime <- lubridate::as_datetime(energy_data$datetime)

mean(energy_data$mwh)
energy_data_by_year <- group_by(energy_data, year)

tail(energy_data_by_year)

summarize(energy_data, mean_energy_usage = mean(mwh, na.rm = TRUE))
year_on_year_energy_usage <- summarize(energy_data_by_year, mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_on_year_energy_usage) <- c("Year", "Mwh")
class(year_on_year_energy_usage)
year_on_year_energy_usage

ggplot(
  data=year_on_year_energy_usage, 
  aes(
    x=Year,
    y=Mwh,
    fill=Year
  )) +
    geom_bar(stat="identity")+
    geom_text(aes(label=Mwh, vjust=-0.2))+
    theme_minimal()


#barplot(year_on_year_energy_usage[,1], main="Average Energy Usage", xlab="Year", ylab="Mwh", legend = year_on_year_energy_usage[,1], beside = TRUE)
