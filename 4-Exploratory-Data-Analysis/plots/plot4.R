library(dplyr)
library(lubridate)


#read the data
data<-read.delim("household_power_consumption.txt", sep = ";", stringsAsFactors = F)

#filter and mutate
data<-data %>%
        filter(., Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(Date = dmy(Date),
               datetime = as.POSIXct(paste(Date, Time)),
               Voltage = as.numeric(Voltage)) %>%
        mutate_at(., vars(starts_with("Sub")), funs(as.numeric(.))) %>%
        mutate_at(., vars(starts_with("Global")), funs(as.numeric(.)))


#plot4
par(mfrow=c(2,2))

plot(data$datetime, data$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

plot(data$datetime, data$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

plot(data$datetime, data$Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", legend = names(data[7:9]), lty=1, col = c("black", "red", "blue"), bty="n", cex =0.8)

plot(data$datetime, data$Global_reactive_power,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")
