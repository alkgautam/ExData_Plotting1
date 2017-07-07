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
reqdata$sub1 <- as.numeric(reqdata$Sub_metering_1); reqdata$sub2 <- as.numeric(reqdata$Sub_metering_2); reqdata$sub3 <- as.numeric(reqdata$Sub_metering_3)

reqdata$Volt <- as.numeric(reqdata$Voltage)
reqdata$GRP <- as.numeric(reqdata$Global_reactive_power)
png("plot4.png")
par(mfrow = c(2,2))
with(reqdata, {
        plot(datetime, GAP, xlab = "",type = "l", ylab = "Global Active Power")
        plot(datetime, Volt, xlab = "datetime", type = "l", ylab = "Voltage")
        plot(datetime, sub1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(datetime,sub2, type = "l", col = "red")
        lines(datetime,sub3, type = "l", col = "blue")
        plot(datetime, GRP, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()