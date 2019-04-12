# Title     : Cleaning Energy Grid data
# Objective : Cleanse Irish Energy Grid data and export to SQLite Database table
# Created by: DanieL Devine
# Created on: 12/04/2019

# Install Dependencies
# install.packages("tidyr")
# install.packages(c("dbplyr", "RSQLite"))
# install.packages("DBI")
# Load dependencies
Packages <- c(
  "tidyr",
  "dbplyr",
  "RSQLite",
  "DBI"
)

lapply(Packages, library, character.only = TRUE)

# Function to remove any rows with empty values 
removeEmptyRows <- function(dataFrame) {
  # Count Total ROws in file
  total_rows <- nrow(dataFrame)
  cat("Total Rows:", total_rows, "\n")
  clearedDataFrame <- na.omit(dataFrame)
  # Count New Total ROws in file
  total_new_rows <- nrow(clearedDataFrame)
  cat("Total Rows Left:", total_new_rows)
  cat("Total Rows Removed:", total_rows - total_new_rows, "\n")
  clearedDataFrame
}


# Load data from CSV
raw_energy <- read.csv('./energy_data.csv')

# Remove Empty Rows
energy_removed_empty <- removeEmptyRows(raw_energy)

# Assign Header to data frame
names(energy_removed_empty) <- c("datetime", "demandtype", "usage", "mwh")

# Check datetime data type
class(energy_removed_empty$datetime)

# Convert string datetime into datetime object
#energy_removed_empty$datetime <- strptime(energy_removed_empty$datetime, format="%d/%m/%Y  %H:%M:%S")

# Convert to time object
energy_removed_empty$datetime <- strptime(energy_removed_empty$datetime, format="%d-%b-%Y %T")

# Check datetime datatype
class(energy_removed_empty$datetime)

#Remove useless columns
energy_removed_empty$demandtype = NULL
energy_removed_empty$usage = NULL

# Check data
head(energy_removed_empty)
tail(energy_removed_empty)

# Check datetime datatype
class(energy_removed_empty$datetime)

# Create SQLite Database
energyDB <- dbConnect(RSQLite::SQLite(), "energy_data.sqlite")

#Reformat datetimeobject to standard ISO String for SQLiteDatabase
energy_removed_empty$datetime <- as.integer(as.POSIXct(energy_removed_empty$datetime))
class(energy_removed_empty$datetime)
class(energy_removed_empty$mwh)
# Write data to SQLite
dbWriteTable(energyDB, "irish_energy_data", energy_removed_empty)