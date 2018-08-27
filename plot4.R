# File name
FILE_NAME <- "plot4"

# Set workspace directory
#setwd("C:/Users/nuno.basto/Documents/R/R Studio/Coursera/Exploratory Data Analysis/Week 1/")

# Create paste to store data
if(!file.exists("./data")){
  dir.create("./data")
}

# Download data file
if(!file.exists("./data/Dataset.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
}

# Unzip data file
if(!file.exists("./data/household_power_consumption.txt")){
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

# Read data
hpc <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")

# Reduce to 2007 February 1st and 2nd
hpc_filtered <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")

# Transforming DateTime into type POSIXlt
hpc_filtered$DateTime <- paste(hpc_filtered$Date, " ", hpc_filtered$Time, sep = "")
hpc_filtered$DateTime <- strptime(hpc_filtered$DateTime, format = "%d/%m/%Y %H:%M:%S")


# Plot the graphic
par(mfrow=c(2,2))

with(hpc_filtered,{
  plot(DateTime,
       as.numeric(as.character(Global_active_power)),
       type = "l",
       xlab = "",
       ylab = "Global Active Power")
  plot(DateTime,
       as.numeric(as.character(Voltage)),
       type = "l",
       xlab = "datetime",
       ylab = "Voltage")
  plot(DateTime,
       Sub_metering_1,
       type = "n",
       xlab = "",
       ylab = "Energy sub metering")
  lines(DateTime,as.numeric(as.character(Sub_metering_1)))
  lines(DateTime,as.numeric(as.character(Sub_metering_2)),col="red")
  lines(DateTime,as.numeric(as.character(Sub_metering_3)),col="blue")
  legend("topright",
         lty = 1,
         col = c("black","red","blue"),
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         cex = 0.6)
  plot(DateTime,
       as.numeric(as.character(Global_reactive_power)),
       type = "l",
       xlab = "datetime",
       ylab = "Global_reactive_power")
})


# Create PNG
dev.copy(png, paste(FILE_NAME, ".png", sep = ""), width = 480, height = 480)
dev.off()