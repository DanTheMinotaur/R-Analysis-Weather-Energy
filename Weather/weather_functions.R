# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 14/04/2019

# Load core functions
source("../functions.R")

# Create connection to weather database
weatherDB <- dbConnect(RSQLite::SQLite(), "weather_data.sqlite")