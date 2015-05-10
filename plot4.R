##Initialize efficient data.table package
library(data.table)

##Initialize variable (powerdata) to full dataset
powerdata<-fread("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE,na.strings="?",header=TRUE)

##Initialize variable (powerdata_short) to date-selected dataset
powerdata_short<-rbind(powerdata[powerdata$Date=="1/2/2007"],powerdata[powerdata$Date=="2/2/2007"])

##Initialize new Data Frame with all relevant data columns that are date-selected
##String paste "Date" and "Time" for use with strptime()
##Assign matchin factors for column names
DT<-data.frame(paste(powerdata_short$Date,powerdata_short$Time),as.numeric(powerdata_short$Global_active_power),as.numeric(powerdata_short$Voltage),as.numeric(powerdata_short$Global_reactive_power),as.numeric(powerdata_short$Sub_metering_1),as.numeric(powerdata_short$Sub_metering_2),as.numeric(powerdata_short$Sub_metering_3))
names(DT)<-c("Date","Global_active_power","Voltage","Global_reactive_power","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##Convert "Date Time" into POSIXlt date object for use in plotting
str_time<-strptime(DT$Date,"%d/%m/%Y %H:%M:%S")

##Initialize PNG graphics device
png("plot4.png",width=480,height=480,units="px")

##Initialize new plot
plot.new()

##Assign plot parameter to accept 2(rows) x 2(rows) graphics
par(mfrow=c(2,2))

##Top Left Plot - Global Active Power
plot(as.POSIXlt(str_time),as.numeric(DT$Global_active_power),type="l",col="black",xlab="",ylab="Global Active Power")

##Top Right Plot - Voltage
plot(as.POSIXlt(str_time),as.numeric(DT$Voltage),type="l",col="black",xlab="datetime",ylab="Voltage")

##Bottom Left Plot - Energy Sub Metering
##bty="n" is used to remove legend border
##cex="0.9" modifies the text size
plot(as.POSIXlt(str_time),as.numeric(DT$Sub_metering_1),type="l",col="black",xlab="",ylab="Energy sub metering")
lines(as.POSIXlt(str_time),as.numeric(DT$Sub_metering_2),col="red")
lines(as.POSIXlt(str_time),as.numeric(DT$Sub_metering_3),col="blue")
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",cex=0.9)

##Bottom Right Plot - Global Reactive Power
plot(as.POSIXlt(str_time),as.numeric(DT$Global_reactive_power),type="l",col="black",xlab="datetime",ylab="Global_reactive_power")

##Close Device
dev.off()
