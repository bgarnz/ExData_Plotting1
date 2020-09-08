plot3 <- function(){
        
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
        
        ## Create plot3, a line graph of energy sub metering over time.
        png(filename = "plot3.png")
        with(data, plot(datetime, Sub_metering_1, 
                         xlab = "", ylab = "Energy sub metering", 
                         type = "l"))
        with(data, lines(datetime, Sub_metering_2, col = "red"))
        with(data, lines(datetime, Sub_metering_3, col = "blue"))
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()
        print("plot3.png created.")
}