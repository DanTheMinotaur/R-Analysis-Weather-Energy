source("functions.R")

#'Load Databases with Energy and Weather Data
energy_data <- load.energydb("./Energy/energy_data.sqlite")
weather_data <- load.weatherdb(5, "./Weather/weather_data.sqlite")

head(energy_data)
head(weather_data)

# Filter out incomplete values
weather_data <- filter(weather_data, year != 2008 & year != 2019)
energy_data <- filter(energy_data, year != 2013 & year != 2019)

#head(energy_data)
#head(weather_data)

# Function pads date interger values with 0 
pad.date <- function(num) {
  str_pad(num, 2, pad = 0)
}

# Group Energy Data By Aveage Usage Per Day
energy_data_day <- summarize(group_by(energy_data, year, month, day), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
energy_data_day$datestring <- paste(energy_data_day$year, pad.date(energy_data_day$month), pad.date(energy_data_day$day), sep = "-")

# Group Energy Data By Aveage Usage Per Month
energy_data_month <- summarize(group_by(energy_data, year, month), mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
count(energy_data_month)
energy_data_month$datestring <- paste(energy_data_month$year, pad.date(energy_data_month$month), sep = "-")

# Group Energy Data By Month
weather_data_month <- summarize_each(group_by(weather_data, year, month), fun=mean, temp, wind_kmh, rain, evap, soil)
count(weather_data_month)
weather_data_month$datestring <- paste(weather_data_month$year, pad.date(weather_data_month$month), sep = "-")

head(weather_data)
head(energy_data)
# Merge Enery Data with Weather by day
weather_energy_data_daily <- merge(weather_data, energy_data, by = "datestring")
head(weather_energy_data_daily)
weather_energy_data_daily$month.y = NULL
weather_energy_data_daily$year.y = NULL
weather_energy_data_daily$day.y = NULL
weather_energy_data_daily$accuracy = NULL
head(weather_energy_data_daily)

weather_energy_data_monthly <- merge(weather_data_month, energy_data_month, by = "datestring")
head(weather_energy_data_monthly)
