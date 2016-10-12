# Downloading, unzipping.
setInternet2(TRUE)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "Electric Power Consumption.zip", method = "auto")
dateDownloaded <- date
unzip("Electric Power Consumption.zip")

# Reading in the file, converting time variables from character, subsetting.
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
household_power_consumption <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?", colClasses = c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
household_power_consumption2 <- subset(household_power_consumption, (Date == "2007-02-01" | Date == "2007-02-02"))
household_power_consumption2$Time <- paste(household_power_consumption2$Date, household_power_consumption2$Time)
household_power_consumption2$Time<-strptime(household_power_consumption2$Time, format="%Y-%m-%d %H:%M:%S")

# Code for Plot 4
png("Plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
par(mar = c(4,4,2,2))
with(household_power_consumption2, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")) 
with(household_power_consumption2, plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "Datetime")) 
with(household_power_consumption2, plot(Time, Sub_metering_1, type = "l", ylab = "Energy submetering", xlab = "", col ="black"))
lines(household_power_consumption2$Time, household_power_consumption2$Sub_metering_2, col = "red")  
lines(household_power_consumption2$Time, household_power_consumption2$Sub_metering_3, col = "green")  
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col= c("black", "red", "green"), lwd = 1) 
with(household_power_consumption2, plot(Time, Global_reactive_power, type = "l", ylab = "Global Rective Power (kilowatts)", xlab = "Datetime")) 
dev.off()