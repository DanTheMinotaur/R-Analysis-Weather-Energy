# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 15/04/2019
source("./DataEnergyAndWeather.R")

# Load Apioiri Algorithm 
Packages <- c(
    "arules",
    "arulesViz"
)
check.packages(Packages)

summary(weather_energy_data_daily)
head(weather_energy_data_daily)

# Convert to Data Object
weather_energy_data_daily$date <- as.Date(weather_energy_data_daily$datestring, format="%Y-%m-%d")
round_columns <- c( "mean_energy_usage", "soil", "evap", "rain", "wind_kmh", "temp")
factor_columns <- c("date", "mean_energy_usage", "soil", "evap", "rain", "wind_kmh", "temp")
# Select useful values
algothm_data <- weather_energy_data_daily[, factor_columns]
head(algothm_data)
algothm_data[, -1] <- round(algothm_data[,round_columns])
#Change Type of columns to factor
algothm_data[factor_columns] <- lapply(algothm_data[factor_columns], factor)
sapply(algothm_data, class)

rule1 <- apriori(algothm_data, parameter = list(support = 0.003, confidence = 0.7))
inspect(head(rule1, 10))
plot(rule1, method="grouped")

