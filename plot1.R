plot1 <- function()
{
  ## reading the txt file
  data <- read.delim("./household_power_consumption.txt", header=TRUE, sep=";", colClasses="character") # c("POSIXct", "POSIXct", rep("numeric",7)))
  
  ## filter the data to the first 2 days in Feb
  FebData = data[as.Date(data$Date, , format="%d/%m/%Y") == as.Date("2007-02-01") | 
                 as.Date(data$Date, , format="%d/%m/%Y") == as.Date("2007-02-02"), ]
  
  ## free memory for original data
  rm(data)
  
  ## convert the FebData columns to numeric
  for (i in 3:9) FebData[,i] = as.numeric(FebData[,i])
  
  ## create plot 1
  with(FebData, hist(Global_active_power, 
                     xlab="Global Active Power (kilowatts)", 
                     col="red", 
                     main = "Global Active Power"))
  
  
  ## save to png
  dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
  dev.off()  ## close the PNG device!
   
  
}