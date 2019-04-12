# Title     : Cleaning Energy Grid data
# Objective : Cleanse Irish Energy Grid data and export to SQLite Database table
# Created by: DanieL Devine
# Created on: 12/04/2019

# Install Dependencies
install.packages("tidyr")
install.packages(c("dbplyr", "RSQLite"))

# Function to remove any rows with empty values 
removeEmptyRows <- function(dataFrame) {
  # Count Total ROws in file
  total_rows <- nrow(dataFrame)
  cat("Total Rows:", total_rows, "\n")
  clearedDataFrame <- na.omit(raw_energy)
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

strptime(energy_removed_empty$datetime, format="%d/%m/%Y  %H:%M:%S")

# Check datetime datatype
class(energy_removed_empty$datetime)

energy_removed_empty$demandtype = NULL

energy_removed_empty
energy_db <- src_sq
