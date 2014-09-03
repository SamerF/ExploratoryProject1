plot2 <- function()
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
  
  ## create plot 2
  with(FebData, plot(Date, Global_active_power, ylab="Global Active Power (kilowatts)", type="l", xlab="     "))
  
  ## save to png
  dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
  dev.off()  ## close the PNG device!  
  
}