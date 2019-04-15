# Load data grouping
source("../weather_groupings.R")
class(weather_daily_average)
colnames(weather_daily_average)

##########################################

# Filter data by year and convert into factor
highestTemp <-filter(weather_daily_average, year > 2014 & year <= 2018)
highestTemp$year <-factor(highestTemp$year)
levels(highestTemp$year)
# Create Density Plot of Temperature
ggplot(highestTemp, aes(x = temp, fill = year)) +
    geom_density(col = NA, alpha = 0.35)
