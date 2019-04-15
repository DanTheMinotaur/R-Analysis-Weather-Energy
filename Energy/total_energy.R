source("./energy_groupings.R")

head(year_month_day_hour_energy_usage)

total_energy_usage_by_year <- summarize(group_by(energy_data, year), total_energy_usage = sum(mwh, na.rm = TRUE))
head(total_energy_usage_by_year, 10)
