# Title     : Create groupings of energy_data from eirgide
# Objective : group data in meaningful ways for data visualisations
# Created by: Daniel Devine
# Created on: 13/04/2019

source("./energy_groupings.R")

View(monthly_energy_usage)
colnames(monthly_energy_usage)

monthly_energy_usage$month <- factor(monthly_energy_usage$month)
monthly_energy_usage$month <- month.abb[monthly_energy_usage$month]

# Bar chart with the energy usage by month. 
ggplot(monthly_energy_usage, aes(x = reorder(month, mean_energy_usage), y = mean_energy_usage)) + 
  geom_bar(stat = "identity", aes(fill = "month")) +
  xlab("Month") +
  ylab("Mwh") + 
  ggtitle("Average Monthly Energy Usage") +
  guides(fill=FALSE)

