# Created on Windows 7 Platform
# Requires lubridate package and assumes lubridate package has been installed

library(lubridate)

# Start of common part of all four R files

# Assumes data file ghas been downloaded and unzipped.
# Rather than downloading (using Windows/Mac script), check if file exists. 
# Stop if file doesnt exist.

# Read just the first few lines of data file and save the header names


if(!file.exists("household_power_consumption.txt")){
      stop("Data file not found: download and unzip using instructions for your OS")
}

df <- read.table("household_power_consumption.txt", header=TRUE, sep = ";",
                 na.strings="?",nrows = 10, 
                 stringsAsFactors = FALSE)


headers<- colnames(df)

# Read the specific range of rows. Determined using iterations of read and 
# checking / based on 60*24 =1440 minutes/onbservations per day  
# Set the variable names from the saved headers 

df <- read.table("household_power_consumption.txt", header=TRUE, sep = ";",
                 na.strings="?",nrows = 2880, skip=66636,
                 stringsAsFactors = FALSE)
colnames(df) <- headers

#---End of Common Part for all four plots/scripts ---#


#combine date and time columns into one column called dateTime.

df$dateTime <- dmy_hms(paste(df$Date, df$Time, sep= " "))

# Initiate PNG device as before

png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# initiate for 1 X 1 layout...in  case it was set otherwise earlier

par(mfrow=c(1,1))


#Initiate plot parameters
with(df, plot(dateTime, Sub_metering_1, ylab = "Energy Sub Metering",
              type = "n", xlab=""))

# Add Submeteing lines - one at a time. 
with(df, lines(dateTime, Sub_metering_1, type ="l", col="black" ,
              xlab=""))

with(df, lines(dateTime, Sub_metering_2, type ="l", col="red",
              xlab=""))

with(df, lines(dateTime, Sub_metering_3, type ="l", col="blue",
              xlab=""))

# Add legend
legend("topright", lwd=2, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()


