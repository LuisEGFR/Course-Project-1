library(dplyr)
library(lubridate)

# read data from txt file, only the first 100.000 to load those 2 days faster
hpc <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows=100000)

# concatenate and convert the Date and Time column to real date/time format (using lubridate package)
hpc$DateTime <- dmy_hms(paste (hpc$Date, hpc$Time))
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y" , tz="Europe/London")

# filter the data set only for the 2 days we need
hpc_2days <- filter (hpc, Date == "2007-02-01" | Date == "2007-02-02" )

# set the locale to English, otherwise the x axis shows my local day names
Sys.setlocale("LC_TIME","English")

# create the plot and save into a PNG file
png(filename = "plot3.png", width = 480, height = 480)
plot(hpc_2days$DateTime, hpc_2days$Sub_metering_1, type="n", xlab="", ylab= "Energy sub metering" )
lines(hpc_2days$DateTime, hpc_2days$Sub_metering_1, lwd=1, type="l", col="black" )
lines(hpc_2days$DateTime, hpc_2days$Sub_metering_2, type="l", col="red" )
lines(hpc_2days$DateTime, hpc_2days$Sub_metering_3, type="l", col="blue")
legend("topright", lty= 1,  lwd =2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
