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

# Code for Plot 1
png("Plot1.png", width = 480, height = 480)
with(household_power_consumption2, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"), ylab = "Frequency")
dev.off()