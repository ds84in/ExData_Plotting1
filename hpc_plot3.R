### Read the full file
readhpc<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

### Convert the date field from factor to Date
readhpc$Date<-as.Date(readhpc$Date,format="%d/%m/%Y")

### Subset the data for the required date range
readhpcsub<-subset(readhpc,Date >= as.Date("2007-02-01",format="%Y-%m-%d") & Date <= as.Date("2007-02-02",format="%Y-%m-%d"))

### Create a datetime field for the plots
readhpcsub$datetime <- as.POSIXlt(paste(readhpcsub$Date,readhpcsub$Time),format="%Y-%m-%d %H:%M:%S")

### Replace the symbol "?" appearing in the data fields to blanks
readhpcsub$Global_active_power<-sapply(readhpcsub$Global_active_power,function(x)gsub("?","",x))
readhpcsub$Global_reactive_power<-sapply(readhpcsub$Global_reactive_power,function(x)gsub("?","",x))
readhpcsub$Global_intensity<-sapply(readhpcsub$Global_intensity,function(x)gsub("?","",x))
readhpcsub$Voltage<-sapply(readhpcsub$Voltage,function(x)gsub("?","",x))
readhpcsub$Sub_metering_1<-sapply(readhpcsub$Sub_metering_1,function(x)gsub("?","",x))
readhpcsub$Sub_metering_2<-sapply(readhpcsub$Sub_metering_2,function(x)gsub("?","",x))
readhpcsub$Sub_metering_3<-sapply(readhpcsub$Sub_metering_3,function(x)gsub("?","",x))

### Convert the data fields to numeric
class(readhpcsub$Global_active_power)<-c("numeric")
class(readhpcsub$Global_reactive_power)<-c("numeric")
class(readhpcsub$Global_intensity)<-c("numeric")
class(readhpcsub$Voltage)<-c("numeric")
class(readhpcsub$Sub_metering_1)<-c("numeric")
class(readhpcsub$Sub_metering_2)<-c("numeric")
class(readhpcsub$Sub_metering_3)<-c("numeric")

## Create Plot 3 and save to png file
with(readhpcsub,plot(datetime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
points(readhpcsub$datetime,readhpcsub$Sub_metering_1,type="l")
points(readhpcsub$datetime,readhpcsub$Sub_metering_2,type="l",col="Red")
points(readhpcsub$datetime,readhpcsub$Sub_metering_3,type="l",col="Blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,file="Plot3.png",width=480,height=480)
dev.off()


