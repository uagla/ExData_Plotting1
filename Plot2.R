##### Code for Plot 2
### This script plots the distribution of the Global Active Power (kilowatts) - the household global minute-averaged active power-,
### according to the date-time during the days 01/02/2007 and 02/02/2007.

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

### 2nd step: Plot 2: Line plot of Global Active Power - the household global minute-averaged active power-,
### according to the date-time during the days 01/02/2007 and 02/02/2007.

## we set the png device
png (filename ="plot2.png",  width = 480 , height = 480, units = "px")

## Plotting the Global Active Power during the
plot(dataset$dateTime,dataset$Global_active_power, type="l", xlab="", ylab="Global Active Power(kilowatts)")

## We set the days in English.
Sys.setlocale("LC_TIME", "English")

dev.off()