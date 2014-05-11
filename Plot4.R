##### Code for Plot 4
### This script plots 4 figures, depicting them into a 2x2 figure matrix.

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
png (filename ="plot4.png",  width = 480 , height = 480, units = "px")

par(mfrow=c(2,2))

## 1rst plot
plot(dataset$dateTime,dataset$Global_active_power, type="l", xlab="", ylab="Global Active Power(kilowatts)")
Sys.setlocale("LC_TIME", "English")

## 2nd plot, located on topright.
plot(dataset$dateTime,dataset$Voltage, type="l", xlab="datetime", ylab="Voltage")
Sys.setlocale("LC_TIME", "English")

## 3rd plot, located on bottom left (it is the same as the Plot3)
plot(dataset$dateTime,dataset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(dataset$dateTime,dataset$Sub_metering_2, type="l", xlab="", ylab="Energy sub metering", col="red")
lines(dataset$dateTime,dataset$Sub_metering_3, type="l", xlab="", ylab="Energy sub metering", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))
Sys.setlocale("LC_TIME", "English")

## 4th plot,located on bottom right.
plot(dataset$dateTime,dataset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
Sys.setlocale("LC_TIME", "English")


dev.off()