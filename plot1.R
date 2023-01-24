#download file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "figures.zip", method = "curl")
unzip("figures.zip")

#install packages for data tidying
install.packages("data.table")
library(data.table)
install.packages("tidyr")
library(tidyr)
install.packages("dplyr")
library(dplyr)
install.packages("lubridate")
library(lubridate)

#read in relevant data set
power <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)
subpower <- power %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

#transform dates and times to Date/Time classes
subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format = "%H:%M:%S")

subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"], "2007-02-01 %H:%M:%S")
subpower[1441:2880, "Time"] <- format(subpower[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

subpower$Time[1:1440] <- format(subpower$Time[1:1440], "2007-02-01 %H:%M:%S")
subpower$Time[1441:2880] <- format(subpower$Time[1441:2880], "2007-02-02 %H:%M:%S")

##[PLOT 1: RED HISTOGRAM OF GLOBAL ACTIVE POWER (KW)]##
subpower$Global_active_power <- as.numeric((subpower$Global_active_power))
plot1 <- hist(subpower$Global_active_power, main = "Global Active Power", 
              xlab = "Gloabl Active Power (kilowatts)",
              ylab = "Frequency",
              col = "red")

#create png of plot
png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(4,4,2,1))

plot1 <- hist(subpower$Global_active_power, main = "Global Active Power", 
              xlab = "Gloabl Active Power (kilowatts)",
              ylab = "Frequency",
              col = "red")




