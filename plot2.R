plot2 <- function(){
        
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
        
        ## Create plot2, a line graph of global active power over time.
        png(filename = "plot2.png")
        with(data, plot(datetime, Global_active_power, 
                         xlab = "", ylab = "Global Active Power (kilowatts)",
                         type = "l"))
        dev.off()
        print("plot2.png created.")
}