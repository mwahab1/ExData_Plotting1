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

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# initiate for 2 X 2 plot layout.

par(mfrow= c(2,2))

# Add the four subplots- one at a time
# Plot 4.1 
with(df, plot(dateTime, Global_active_power, type ="l", 
              ylab="Global Active Power (kilowatts)",
              xlab=""))

# Plot 4.2
with(df, plot(dateTime, Voltage, type ="l"))

#plot 4.3

### slight differce from Plot3....dont do the xlab ="". Let it generate dateTime
### Also no border/box around legend box.
### cex = 0.75 (to mak sure the legend is not too large compared to the plot)
with(df, plot(dateTime, Sub_metering_1, ylab = "Energy Sub Metering",
              type = "n"))

with(df, lines(dateTime, Sub_metering_1, type ="l", col="black" ,
               xlab=""))

with(df, lines(dateTime, Sub_metering_2, type ="l", col="red",
               xlab=""))

with(df, lines(dateTime, Sub_metering_3, type ="l", col="blue",
               xlab=""))

legend("topright", lwd=2, bty="n", col = c("black", "red", "blue"), 
       cex=0.75,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))





#plot 4.4
with(df, plot(dateTime, Global_reactive_power, type ="l"))


dev.off()


#dev.print(png, file = "plot4_a.png", width = 480, height = 480) 