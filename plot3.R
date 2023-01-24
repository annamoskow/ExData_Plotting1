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

##[PLOT 3: SUB METERING 1/2/3 TIME SERIES]##

plot(subpower$Time, as.numeric(as.character(subpower$Sub_metering_1)),
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)
title(main = "Sub Metering 1/2/3 Vs Time")

lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_2)),
     type = "l",
     col = "red"
     )

lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_3)),
      type = "l",
      col = "blue"
      )

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

#create png of plot
png("plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(4,4,2,1))

plot(subpower$Time, as.numeric(as.character(subpower$Sub_metering_1)),
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)
title(main = "Sub Metering 1/2/3 Vs Time")

lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_2)),
      type = "l",
      col = "red"
)

lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_3)),
      type = "l",
      col = "blue"
)

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

dev.off()
