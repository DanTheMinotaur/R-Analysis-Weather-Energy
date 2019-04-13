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
energy_data