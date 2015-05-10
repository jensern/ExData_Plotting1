##import efficient data.table package
library(data.table)

##assign variable (powerdata) to full dataset
powerdata<-fread("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE,na.strings="?",header=TRUE)

##assign date-selected variable (powerdata_short)
powerdata_short<-rbind(powerdata[powerdata$Date=="1/2/2007"],powerdata[powerdata$Date=="2/2/2007"])

##initialize PNG graphic devices
png(file="plot1.png",width=480,height=480,units="px",bg="white")

##plot histogram of global active power, coloured red
hist(as.numeric(powerdata_short$Global_active_power),col="Red",main="Global Active Power", xlab="Global Active Power (kilowatts)",breaks="Sturges")

##close device
dev.off()