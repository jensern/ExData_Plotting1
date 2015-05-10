##Load effient data.table package
library(data.table)

##Assign variable (powerdata) for full dataset
powerdata<-fread("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE,na.strings="?",header=TRUE)

##Assign variable (powerdata_short) for date-selected dataset
powerdata_short<-rbind(powerdata[powerdata$Date=="1/2/2007"],powerdata[powerdata$Date=="2/2/2007"])

##Create new smaller data frame with only Date,Time,Global Active Power
##Paste character strings of Date & Time for usage with strptime() into single column
##Coerce Global Active Power to numeric for plotting values
##Assign factors to new data frame for easy access
gl_act_pwr<-data.frame(paste(powerdata_short$Date,powerdata_short$Time),as.numeric(powerdata_short$Global_active_power))
names(gl_act_pwr)<-c("Date","Global_active_power")

##Utilize strptime to convert character object of pasted "Date Time" into POSIXlt object
##Important to note that the format should use %Y instead of %y for the 4-digit year value
str_time<-strptime(gl_act_pwr$Date,"%d/%m/%Y %H:%M:%S")

##Initialize PNG graphics device 
png("plot2.png",width=480,height=480,units="px")

##Plot x-y scatter plot object with Time as X-axis and Global_active_power as Y-axis
plot(as.POSIXlt(str_time),as.numeric(gl_act_pwr$Global_active_power),type="l",ylab="Global Active Power (kilowatts)",xlab="")

##Close device
dev.off()

