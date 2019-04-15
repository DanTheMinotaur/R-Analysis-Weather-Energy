 

source("../weather_groupings.R")

View(weather_yearly_average)

weather_yearly_average <- filter(weather_yearly_average, year != 2008 & year != 2019)
weather_yearly_average

ggplot(weather_yearly_average, aes(x = year)) +
  geom_line(aes(y = temp, color = "temp")) +
  scale_color_discrete(name = "Weather Data", labels = c("Temperature (Celcius)")) +
  stat_smooth(aes(y = temp), method = "lm") +
  xlab("Year") +
  ylab("Degrees C") +
  ggtitle("Average Temperature Year By Year")