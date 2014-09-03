plot4 <- function()
{
  ## reading the txt file
  data <- read.delim("./household_power_consumption.txt", header=TRUE, sep=";", colClasses="character") # c("POSIXct", "POSIXct", rep("numeric",7)))
  
  ## filter the data to the first 2 days in Feb
  FebData = data[as.Date(data$Date, , format="%d/%m/%Y") == as.Date("2007-02-01") | 
                   as.Date(data$Date, , format="%d/%m/%Y") == as.Date("2007-02-02"), ]
  
  ## free memory for original data
  rm(data)
  
  ## merge the Date and Time into one column, and then convert to Date
  FebData$Date = paste(FebData$Date, FebData$Time)
  FebData$Date = as.POSIXlt(FebData$Date, format="%d/%m/%Y %H:%M:%S")
  
  ## convert the rest of the columns to numeric
  for (i in 3:9) FebData[,i] = as.numeric(FebData[,i])
  
  ## create the 4 chart canvas
  par(mfrow=c(2,2))
  
  ## create chart 1 (same as plot2.png)
  with(FebData, plot(Date, Global_active_power, type="l", ylab="Global Active Power", xlab="      "))
  
  ## Create chart 2 (datetime vs. voltage)
  with(FebData, plot(Date, Voltage, ylab="Voltage", xlab="datetime", type="l"))
  
  ## Create chart 3 (same as plot3.png)   
  with(FebData, plot(Date, Sub_metering_1, ylab="Energy sub metering", type="l", col="black", xlab="      "))
  with(FebData, points(Date, Sub_metering_2, ylab="Energy sub metering", type="l", col="red", xlab="      "))
  with(FebData, points(Date, Sub_metering_3, ylab="Energy sub metering", type="l", col="blue", xlab="      "))
  legend("topright", pch = '_', bty = "n", cex=0.6, inset=0.035, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## Create chart 4
  with(FebData, plot(Date, Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l"))
  
  ## save to png
  dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
  dev.off()  ## close the PNG device!
  
  ## reset the screen device to 1 row and 1 column
  par(mfrow=c(1,1))
   
}