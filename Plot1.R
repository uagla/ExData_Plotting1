##### Code for Plot 1

### This script plots the histogram of the Global Active Power (kilowatts), which means the household global minute-averaged active power.

### 1rst step: We first need to load the function which reads and subsets the data set.
###### Script done for getting data set
##  A function is developed for  getting the dataset
## In your working directory should be located the household_power_consumption.txt file  UCI HAR Dataset. From this folder
## the file should be read.

getTable<-function(){
   pathFile<-file.path(getwd(),"household_power_consumption.txt")
   fieldClass <- c(rep("character", 2),rep("numeric",7))
   electric<-read.table(pathFile, sep=";",
                      header =TRUE, colClasses = fieldClass, dec=".",na.strings="?")


   ### We subset the data for only 01/02/2007 and 02/02/2007  and return it.
   elecset<-electric[electric$Date %in% c("2/2/2007","1/2/2007"),]

   ###  Once we have read the Table, we transform the variables related to Date and Time for performing the graphs properly.
   elecset$dateTime <- as.POSIXct(strptime(paste(elecset$Date,elecset$Time), "%d/%m/%Y %H:%M:%OS"))
   elecset$Date <- as.Date(elecset$Date, format="%d/%m/%Y")
   elecset$Time <- strptime(elecset$Time,format="%H:%M:%OS")
   elecset

}

### we call and execute the function in order to get the desired data.

dataset<-getTable()

### 2nd step: Plot 1: histogram of Global Active Power

## we set the png device
png (filename ="plot1.png",  width = 480 , height = 480, units = "px")

## hist() function for plotting histograms
hist(dataset$Global_active_power,xlab="Global Active Power(kilowatts)", main="Global Active Power",
     col="red")
dev.off()