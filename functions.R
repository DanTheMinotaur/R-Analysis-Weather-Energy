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

# Load project packages
Packages <- c(
    "DBI",
    "tidyverse",
    "lubridate"
)

check.packages(Packages)

# Loads Energy SQLlite DB and returns the connection object
load.energydb <- function( db_file = "energy_data.sqlite"){
    con <- dbConnect(RSQLite::SQLite(), db_file)
    dbReadTable(con, "irish_energy_data")
}

# Loads Weather Data, optional parametre to specify the weather station accuracy value[1-5] set to 0 for all data
load.weatherdb <- function(accuracy = 0, db_file = "weather_data.sqlite") {
    con <- dbConnect(RSQLite::SQLite(), db_file)
    if (accuracy == 0) {
        dbReadTable(con, "irish_average_weather")
    } else {
        query_result <- dbSendQuery(con,
            paste("SELECT * FROM irish_average_weather WHERE accuracy >= ", accuracy, sep="")
        )
        dbFetch(query_result)
    }

}