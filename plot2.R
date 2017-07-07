if (!dir.exists("Data")) { dir.create("Data")
        setwd("./Data")
}
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = url1,destfile = "power.zip",mode = "wb")
unzip("power.zip")
power <- read.table("household_power_consumption.txt",header = T,sep = ";",stringsAsFactors = F,dec = ".")
head(power)
reqdata <- power[power$Date %in% c("1/2/2007","2/2/2007"),]
reqdata$GAP <- as.numeric(reqdata$Global_active_power)
reqdata$datetime <- strptime(paste(reqdata$Date,reqdata$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
png("plot2.png")
with(reqdata, plot(datetime, GAP, type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.off()