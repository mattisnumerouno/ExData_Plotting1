# note: the extracted, unzipped folder should be located in your working directory
powertop5 <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt"
                        , header = TRUE, sep = ";", na.strings = "?", nrows = 5)
classes <- sapply(powertop5, class)
power <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt"
                    , header = TRUE, sep = ";", na.strings = "?", colClasses = classes)
DateTime <- transform(power, DTchar = paste(power$Date, power$Time, sep = " "))
DT <- strptime(DateTime$DTchar, format = "%d/%m/%Y %H:%M:%S")
DateTime$DTTM <- DT
DateTime$Date <- NULL
DateTime$Time <- NULL
DateTime$DTchar <- NULL
Final <- DateTime[(DateTime$DTTM >= "2007-02-01 00:00:00") & (DateTime$DTTM <= "2007-02-03 00:00:00"),]
#end data cleaning step

with(Final, plot(Final$DTTM, Final$Sub_metering_1 ,  xlab = "", ylab = "Energy sub metering", type = "l", col = "black"))
lines(Final$DTTM, Final$Sub_metering_2, col = "red")
lines(Final$DTTM, Final$Sub_metering_3, col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), cex = 1.2, y.intersp = 0.25,
       x.intersp = 1.2)
dev.copy(png, file = "plot3.png", width = 480, height = 480, res = 50)
dev.off()