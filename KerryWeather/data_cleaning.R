"
Hourly Elements:

ID	        ELEMENT                                                        Unit

rain		Precipitation Amount						mm
temp       	Air Temperature 	                                        °C
wetb		Wet Bulb Air Temperature			                °C
dewpt		Dew Point Air Temperature					°C
vappr		Vapour Pressure							hpa
rhum		Relative Humidity						%
msl		Mean Sea Level Pressure						hPa
wdsp		Mean Hourly Wind Speed						kt
wddir		Predominant Hourly wind Direction				kt
ww		Synop Code Present Weather - decode below
w		Synop Code Past Weather - decode below
sun		Sunshine duration						hours
vis		Visibility							m
clht		Cloud Ceiling Height - if none value is 999			100s feet
clamt		Cloud Amount							okta


Indicators (i)	    Description  - Decode

irain		Rainfall Indicators:		0. satisfactory.
				        	1. deposition.
				        	2. trace or sum of precipition.
				        	3. trace or sum of deposition.
						4. estimate precipitation.
				      		5 estimate deposition.
						6. estimate trace of precipitation.

itemp		Temperature Indicators: 	0. positive.
						1. negative.
						2. positive estimated.
						3. negative estimated.
						4. not available.

iwb  		Wet Bulb Indicators:    	0:positive.
						1. negative.
						2. positive estimated.
						3. negative estimated.
				        	4. not available.
						5. frozen negative.

iwdsp		Wind Speed Indicators:		2. Over 60 minutes.
						4. Over 60 minutes and defective
						6 Over 60 minutes and partially defective.
						7. n/a

iwddir		Wind Direction Indicators:  	2. Over 60 minutes.
						4. Over 60 minutes and defective
						6 Over 60 minutes and partially defective.
						7. n/a
"
# Script Start
weather_data = read.csv("data_split.csv", header=TRUE)
#weather_data

# Assign column_names
column_names <- c(
    "datetime", # Date and Time (utc)
    "rain_mm_i", # Rail indicator
    "rain_mm", # Precipitation Amount (mm)
    "air_temp_i", # Air temp Indicator
    "air_temp", # Air Temperature (C)
    "wet_bulb_temp_i", # Wet Bulb Temperature Indicator
    "wet_bulb_temp", # Wet Bulb Temperature (C)
    "dew_point_temp", # Dew Point Temperature (C)
    "vapour", # Vapour Pressure (hPa)
    "rel_hum", # Relative Humidity (%)
    "mean_sea_level", # Mean Sea Level Pressure (hPa)
    "wind_speed_i", # Wind Speed Indicator
    "mean_wind_speed", # Mean Wind Speed (knot)
    "wind_direc_i", # Predominant Wind Direction Indicator
    "wind_direc", # Predominant Wind Direction (degree)
    "present_w", # Synop code for Present Weather
    "past_w", # Synop code for Past Weather
    "sunshine", # Sunshine duration (hours)
    "visibility", # Visibility (m)
    "cloud_height", # Cloud height (100's of ft) - 999 if none
    "cloud_amount" # Cloud amount
)

# Assign more meaningful names to data
names(weather_data) <- column_names

# Format String datetime to be usable
weather_data$datetime <- strptime(weather_data$datetime, format="%d-%b-%Y %H:%M")

# Split date and time into own columns
weather_data$date <- as.Date(weather_data$datetime)
weather_data$time <- format(weather_data$datetime, "%H:%M")

library("dplyr")

weather_data