library(lubridate)

#Read the entire dataset into R
setwd("C://Users//kruthika//Documents//Data analysis related//Coursera//Exploratory Data Analysis//Week 1")
power <- read.table("household_power_consumption.txt", sep=";", header = TRUE)


#Generate the subsetted dataset which contains only data from the required dates
power$Date <- dmy(power$Date)
power_req <- subset(power,(Date=="2007-02-01" | Date=="2007-02-02"))
rm(power)

#Format the columns of power_req to the numeric value for plotting
power_req$Global_reactive_power <- as.numeric(as.character(power_req$Global_reactive_power))
power_req$Global_active_power <- as.numeric(as.character(power_req$Global_active_power))
power_req$Sub_metering_1 <- as.numeric(as.character(power_req$Sub_metering_1))
power_req$Sub_metering_2 <- as.numeric(as.character(power_req$Sub_metering_2))
power_req$Sub_metering_3 <- as.numeric(as.character(power_req$Sub_metering_3))
power_req$Voltage <- as.numeric(as.character(power_req$Voltage))

#constructing a merged date-time column
power_req$Date.Time <- with(power_req, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M"))





#Clear the graphics device
dev.off()

#initialising png graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))
dev.cur() #checking to see the current active device

#plotting graph 1
with(power_req,plot(Date.Time,Global_active_power, main="",type = "n",ylab = "Global Active Power",xlab=""))
lines(power_req$Date.Time,power_req$Global_active_power)

#plotting graph 2
with(power_req,plot(Date.Time,Sub_metering_1, main="",type = "n",ylab = "Energy sub metering",xlab=""))
lines(power_req$Date.Time,power_req$Sub_metering_1, col = "black")
lines(power_req$Date.Time,power_req$Sub_metering_2, col = "red")
lines(power_req$Date.Time,power_req$Sub_metering_3, col = "blue")
legend("topright",lty=c(1,1),col=c("black","blue","red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty="n",cex=0.9)

#plotting graph 3
with(power_req,plot(Date.Time,Voltage, main="",type = "n",ylab = "Voltage",xlab="datetime"))
lines(power_req$Date.Time,power_req$Voltage)

#plotting graph 4
with(power_req,plot(Date.Time,Global_reactive_power, main="",type = "n",ylab = "Global_reactive_power",xlab="datetime"))
lines(power_req$Date.Time,power_req$Global_reactive_power)

#Close the png graphics device
dev.off()