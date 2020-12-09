# Read selected data from working directory into R
files <- file('./household_power_consumption.txt')
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

# Convert data and time to correct format  
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')  
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")) 

# Open graphics device  
if(!file.exists('figures')) dir.create('figures')  
png(filename = './figures/plot4.png', width = 480, height = 480, units='px')  

# Set up graphic
par(mfrow = c(2, 2))

# Plot graph
## Graph 1
with(data,
     plot(DateTime,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power"))
## Graph 2
with(data,
     plot(DateTime,
          Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))
## Graph 3
with(data,
     plot(DateTime,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(data,
     points(DateTime,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(data,
     points(DateTime,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
## Graph 4
with(data,
     plot(DateTime,
          Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))

# Close device  
dev.off()