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

# Function designed to take a MWH grouping for a single hour
convert.mwh <- function(mwh, num_hours){
    <- mwh / num_hours
}


Packages <- c(
    "DBI",
    "tidyverse"
)

check.packages(Packages)

# Loads Energy SQLlite DB and returns the connection object
load.energydb <- function(){
    con <- dbConnect(RSQLite::SQLite(), "energy_data.sqlite")
    dbReadTable(con, "irish_energy_data")
}
