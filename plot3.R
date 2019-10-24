if (!file.exists("R/Coursera_Data_Science_Specialization/Exploratory_Data_Analysis/week1")) {
  dir.create("week1")
}

if (!file.exists("household_power_consumption.txt")){
  datalocation<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url = datalocation, destfile = "./R/Coursera_Data_Science_Specialization/Exploratory_Data_Analysis/week1/household_power_consumption.zip", mode="wb")
}

uzpfile<-unzip("./R/Coursera_Data_Science_Specialization/Exploratory_Data_Analysis/week1/household_power_consumption.zip")

hpc<-read.table("./household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE, col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#subset the data to only the dates you are interested in
subsetdata<-hpc[hpc$Date %in% c("1/2/2007", "2/2/2007"),]

#paste togtether the date and time columns
DateTime<-paste(subsetdata$Date, subsetdata$Time, sep=" ")

#change the pasted together and date and time column into a date and time class 
DateandTime<-strptime(DateTime, format="%d/%m/%Y %H:%M:%S")

#create a subset of data which does not have the original date and time columns
cleandata<-subsetdata[,!(names(subsetdata) %in% c("Date", "Time"))]

#column bind the date and time column you created with the subset of data 
wholedata<-cbind(DateandTime, cleandata)

wholedata$Global_active_power<-as.numeric(wholedata$Global_active_power)

#make plot 3
png(file="plot3.png", height=480, width=480, units="px")
plot(wholedata$DateandTime, wholedata$Sub_metering_1, type="l", xlab=" ", ylab="Energy sub metering")
lines(wholedata$DateandTime, wholedata$Sub_metering_2, col="red")
lines(wholedata$DateandTime, wholedata$Sub_metering_3, col="blue")
legend("topright", lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()