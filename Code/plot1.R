#Read in data. Subset to the desired dates. Add a 'datetime' field
#that synthesizes the Date and Time fields for ordering in plots.
#Report all numeric values as numerics

data<-read.table("household_power_consumption.txt",header =TRUE,sep=';',na.strings = "?")
data<-within(data, date2 <- as.Date(Date,format = "%d/%m/%Y"))

filtered<-data[data$date2=="2007-1-2" | data$date2=="2007-2-2",]
filtered<-within(filtered, datetime <- as.POSIXlt(paste(Date,Time),
                                                  format = "%m/%d/%Y %H:%M:%S"))

#Create Desired Plots

with(filtered,{hist(Global_active_power,col='red',main = "Global Active Power",
                    xlab = "Global Active Power (kilowatts)",xlim = c(0,6))})

#Export the plots from the plotting device to a PNG
quartz()
dev.copy(png, file="plot1.png")
dev.off()