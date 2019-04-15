# Title     : Test Analysis' about energy usage data
# Objective : TODO
# Created by: Daniel Devine
# Created on: 13/04/2019

source("../functions.R")

# Load energy data from DB
con <- load.energydb()
energy_data <- dbReadTable(con, "irish_energy_data")

# Average Energy usage
mean(energy_data$mwh)

# Groupd Energy data usage by year and average/mean values
energy_data_by_year <- group_by(energy_data, year)
year_on_year_energy_usage <- summarize(energy_data_by_year, mean_energy_usage = round(mean(mwh, na.rm = TRUE), 2))
colnames(year_on_year_energy_usage) <- c("Year", "Mwh")
year_on_year_energy_usage

# Create Bar Plot with data
yearly_energy_usage_bar_plot <- ggplot(
  data=year_on_year_energy_usage, 
  aes(
    x=Year,
    y=Mwh,
    fill=Year
  )) +
    geom_bar(stat="identity")+
    geom_text(aes(label=Mwh, vjust=-0.2))+
    theme_minimal()

yearly_energy_usage_bar_plot
