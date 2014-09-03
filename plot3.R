plot3 <- function()
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
  
  ## convert the rest of the numeric columns
  for (i in 3:9) FebData[,i] = as.numeric(FebData[,i])
  
  par(mar=c(5,4,4,1))
  
  ## create plot 3
  with(FebData, plot(Date, Sub_metering_1, ylab="Energy sub metering", type="l", col="black", xlab="      "))
  with(FebData, points(Date, Sub_metering_2, ylab="Energy sub metering", type="l", col="red", xlab="      "))
  with(FebData, points(Date, Sub_metering_3, ylab="Energy sub metering", type="l", col="blue", xlab="      "))
  legend("topright", pch = '_', cex=0.85, inset=0.035, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## save to png
  dev.copy(png, file = "plot3.png")  ## Copy my plot to a PNG file
  dev.off()  ## close the PNG device!
  
  
}