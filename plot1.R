library(dplyr)

data <- readRDS('./inputData/summarySCC_PM25.rds')

emiYear <- data %>% group_by(year) %>% summarise(total=sum(Emissions))

plot1 <- barplot(emiYear$total/1000,names.arg=emiYear$year,xlab="Years",ylab="Emissions in kiloton",main="PM2.5 Emissions in years",col='red',ylim = c(0,8000))

text(plot1,round(emiYear$total/1000),label = round(emiYear$total/1000),pos=3,cex =1.2)

dev.copy(png,'plot1.png')
dev.off()