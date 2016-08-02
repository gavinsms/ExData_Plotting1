#Read in data. Subset to the desired dates. Add a 'datetime' field
#that synthesizes the Date and Time fields for ordering in plots.
#Report all numeric values as numerics

data<-read.table("household_power_consumption.txt",header =TRUE,sep=';',na.strings = "?")
data<-within(data, date2 <- as.Date(Date,format = "%d/%m/%Y"))

filtered<-data[data$date2=="2007-1-2" | data$date2=="2007-2-2",]
filtered<-within(filtered, datetime <- as.POSIXlt(paste(Date,Time),
                                                  format = "%m/%d/%Y %H:%M:%S"))


#Create Desired Plots
with(filtered,{
  plot(datetime,Sub_metering_1, type="n",xlab="",
       ylab="Energy submetering",ylim=c(0,40))
})

with(filtered,{
  lines(datetime,Sub_metering_1, type="l")
})

with(filtered,{
  lines(datetime,Sub_metering_2, type="l",col="red")
})

with(filtered,{
  lines(datetime,Sub_metering_3, type="l",col="blue")
})

legend("topright",c("Sub Metering 1", "Sub Metering 2","Sub Metering 3"),
       col=c("black","red","blue"),lty=1)

#Export the plots from the plotting device to a PNG
quartz()
dev.copy(png, file="plot3.png")
dev.off()
