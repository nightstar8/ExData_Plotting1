# Read selected data from working directory into R
files <- file('./household_power_consumption.txt')
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

# Convert data and time to correct format  
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')  
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")) 

# Open graphics device  
if(!file.exists('figures')) dir.create('figures')  
png(filename = './figures/plot3.png', width = 480, height = 480, units='px')  

# Plot graph
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
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)

# Close device  
dev.off()