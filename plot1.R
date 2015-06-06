

# Created on Windows 7 Platform
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

# Initiate a png device

png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))


#create histogram. Set Xlabel and title

hist(df$Global_active_power, col = "red", 
     xlab="Global Active Power (kilowatts)",
     main = "Global Active Power")


dev.off()
