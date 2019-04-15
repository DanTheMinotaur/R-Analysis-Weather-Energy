source("./energy_groupings.R")

# Remove 2013 as incomplete year
year_month_day_hour_energy_usage <- filter(year_month_day_hour_energy_usage, year != 2013)

# break down data by hour to calculate MegaWatt Usage, then sums each average hour and divides by 1000 to get TeraWatt Usage
total_energy_usage_by_year <- summarize(group_by(year_month_day_hour_energy_usage, year), total_energy_usage = sum(mean_energy_usage, na.rm = TRUE) / 1000000)

head(total_energy_usage_by_year, 10)

# Bar chart with the energy usage by month. 
ggplot(total_energy_usage_by_year, aes(x = reorder(year, total_energy_usage), y = total_energy_usage)) + 
  geom_bar(stat = "identity", aes(fill = "month")) +
  geom_text(aes(label=total_energy_usage, vjust=0) +
  xlab("Year") +
  ylab("TeraWatt Usage") + 
  ggtitle("Yearly Energy Usage") +
  guides(fill=FALSE)