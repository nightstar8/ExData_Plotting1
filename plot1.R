# Read selected data from working directory into R
files <- file('./household_power_consumption.txt')
data <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

# Open graphics device  
if(!file.exists('figures')) dir.create('figures')  
png(filename = './figures/plot1.png', width = 480, height = 480, units='px')  

# Plot  
with(data, hist(Global_active_power, xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'red'))  

# Close device  
dev.off()