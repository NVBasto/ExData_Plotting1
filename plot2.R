# File name
FILE_NAME <- "plot2"

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
plot(hpc_filtered$DateTime,as.numeric(as.character(hpc_filtered$Global_active_power)),
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")


# Create PNG
dev.copy(png, paste(FILE_NAME, ".png", sep = ""), width = 480, height = 480)
dev.off()