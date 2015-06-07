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
with(Final, plot(DTTM, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", 
                 type = "l",pch = "."))
dev.copy(png, file = "plot2.png", width = 480, height = 480, res = 50)
dev.off()