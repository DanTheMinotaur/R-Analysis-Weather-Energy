# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 13/04/2019

# Function takes vector of packages and installs them if not otherwise just includes them
check.packages <- function(Package){
    new.pkg <- Package[!(Package %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(Package, require, character.only = TRUE)
}

Packages <- c(
    "DBI",
    "tidyverse",
    "lubridate"
)

check.packages(Packages)

# Loads Energy SQLlite DB and returns the connection object
load.energydb <- function(){
    con <- dbConnect(RSQLite::SQLite(), "energy_data.sqlite")
    dbReadTable(con, "irish_energy_data")
}

# Loads Weather Data, optional parametre to specify the weather station accuracy value[1-5] set to 0 for all data
load.weatherdb <- function(accuracy = 0) {
    con <- dbConnect(RSQLite::SQLite(), "weather_data.sqlite")
    if (accuracy == 0) {
        dbReadTable(con, "irish_average_weather")
    } else {
        query_result <- dbSendQuery(con,
            paste("SELECT * FROM irish_average_weather WHERE accuracy >= ", accuracy, sep="")
        )
        dbFetch(query_result)
    }

}