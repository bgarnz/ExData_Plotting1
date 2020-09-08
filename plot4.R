plot4 <- function(){
        
        library(sqldf)
        
        ##Download the file to local directory and read it.
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "household_power_consumption.zip")
        unzip("household_power_consumption.zip",
              "household_power_consumption.txt")
        data <- read.csv.sql("household_power_consumption.txt", header = TRUE, 
                             sep = ";", sql = "select * from file where 
                             (Date == '1/2/2007' OR Date == '2/2/2007')")
        
        ##Combine date and time to useable new variable.
        data$datetime <- as.POSIXct(paste(data$Date, data$Time), 
                                     format = "%d/%m/%Y %H:%M:%S")
        
        ## Create plot4, 4 different graphs.
        png(filename = "plot4.png")
        par(mfrow = c(2,2), mar = c(4,4,2,1))
        with(data, plot(datetime, Global_active_power, 
                         xlab = "", ylab = "Global Active Power", type = "l"))
        with(data, plot(datetime, Voltage, type = "l"))
        with(data, plot(datetime, Sub_metering_1, 
                         xlab = "", ylab = "Energy sub metering", 
                         type = "l"))
        with(data, lines(datetime, Sub_metering_2, col = "red"))
        with(data, lines(datetime, Sub_metering_3, col = "blue"))
        legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        with(data, plot(datetime, Global_reactive_power, type = "l"))
        dev.off()
        print("plot4.png created.")
}