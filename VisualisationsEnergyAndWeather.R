# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 15/04/2019

source("./DataEnergyAndWeather.R")

head(weather_energy_data_daily)
# Convert DateString to date object
weather_energy_data_daily$date <- as.Date(weather_energy_data_daily$datestring, format = "%Y-%m-%d")

weather_energy_data_monthly$datestring <- factor(weather_energy_data_monthly$datestring )
head(weather_energy_data_monthly)

# 2D Desity Visualisation Temp V Energy
ggplot(weather_energy_data_daily, aes(x = temp, y = mean_energy_usage)) +
    geom_density_2d() +
    xlab("Temp C") +
    ylab("Energy Mwh")

# 2D Desity Visualisation Temp V Energy using Virdis Fill
ggplot(weather_energy_data_daily, aes(x = temp, y = mean_energy_usage)) +
  stat_density_2d(geom = "tile",
                  aes(fill = ..density..),
                  contour = FALSE) +
  scale_fill_viridis_c() +
  xlab("Temp C") +
  ylab("Energy Mwh")

# 2D Desity Visualisation Temp V Energy using Virdis Fill
ggplot(weather_energy_data_daily, aes(x = rain, y = mean_energy_usage)) +
  stat_density_2d(geom = "tile",
                  aes(fill = ..density..),
                  contour = FALSE) +
  scale_fill_viridis_c() +
  xlab("Rain MM") +
  ylab("Energy Mwh")


# Line Comparing Rain and Energy - No Meaningful data
ggplot(weather_energy_data_monthly, aes(x = datestring)) + 
  geom_line(aes(y = rain, color = "rain")) + 
  geom_line(aes(y = mean_energy_usage / 100, color = "mean_energy_usage"))

# Box Plots - no meaningful info.
ggplot(weather_energy_data_daily_2015, aes(x = temp, y = mean_energy_usage)) +
  geom_boxplot()
ggplot(weather_energy_data_daily, aes(x = rain, y = mean_energy_usage))
  geom_line()
  
  