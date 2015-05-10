##Load efficient data.table package
library(data.table)

##Assign variable (powerdata) to full dataset
powerdata<-fread("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE,na.strings="?",header=TRUE)

##Assign variable (powerdata_short) to date-selected dataset
powerdata_short<-rbind(powerdata[powerdata$Date=="1/2/2007"],powerdata[powerdata$Date=="2/2/2007"])

##Assign variable for Sub_metering_values with Pasted Date-Time character strings
##Assign factors to columns for easy access
sub_meter_pwr<-data.frame(paste(powerdata_short$Date,powerdata_short$Time),as.numeric(powerdata_short$Sub_metering_1),as.numeric(powerdata_short$Sub_metering_2),as.numeric(powerdata_short$Sub_metering_3))
names(sub_meter_pwr)<-c("Date","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##Convert string pasted "Date Time" into POSIXlt object to be used a values for time in X-axis
str_time<-strptime(sub_meter_pwr$Date,"%d/%m/%Y %H:%M:%S")

##Initialize new plot
plot.new()

##Initialize PNG graphics device
png("plot3.png",width=480,height=480,units="px")

##Plot first dataset for Sub_metering 1 in BLACK
plot(as.POSIXlt(str_time),as.numeric(sub_meter_pwr$Sub_metering_1),type="l",col="black",xlab="",ylab="Energy sub metering")

##Add line plot for Sub_metering 2 in RED
lines(as.POSIXlt(str_time),as.numeric(sub_meter_pwr$Sub_metering_2),col="red")

##Add line plot for Sub_metering 3 in BLUe
lines(as.POSIXlt(str_time),as.numeric(sub_meter_pwr$Sub_metering_3),col="blue")

##Incorporate matching legend
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Close Device
dev.off()

