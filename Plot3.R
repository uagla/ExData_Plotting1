##### Code for Plot 3
### This script plots the distribution of the Energy sub metering,
### according to the three types:
#### 1.- the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered)
#### 2.- laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#### 3.- electric water-heater and an air-conditioner.

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

### 2nd step: Plot 3: plots the distribution of the Energy sub metering, according to the three aforementioned types.

## we set the png device
png (filename ="plot3.png",  width = 480 , height = 480, units = "px")

## Plotting the Global Active Power during the
plot(dataset$dateTime,dataset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(dataset$dateTime,dataset$Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red")
lines(dataset$dateTime,dataset$Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue")

## Legend location and its features

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

## We set the days in English.
Sys.setlocale("LC_TIME", "English")

dev.off()