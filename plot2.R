

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

png(filename = "plot2.png",
width = 480, height = 480, units = "px", pointsize = 12,
bg = "white", res = NA, family = "", restoreConsole = TRUE,
type = c("windows", "cairo", "cairo-png"))


# plot line graph to PNG device
with(df, plot(dateTime, Global_active_power, 
              type ="l",                              # line graph 
              ylab="Global Active Power (kilowatts)", # set y label
              xlab=""))                               # clear x label

# turn off PNG device. Necessary.
dev.off()






