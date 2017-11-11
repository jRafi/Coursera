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


#plot1
hist(data$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col = "red",
     ylim = c(0, 1200)
     )

