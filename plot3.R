library(dplyr)
library(ggplot2)

data <- readRDS('./inputData/summarySCC_PM25.rds')

#Filtering the Baltomre city
sset = subset(data,fips == "24510")

#Grouping with type and year
emi_balti <- sset %>% group_by(type,year) %>% summarise(total=sum(Emissions))

gplot1 <- ggplot(emi_balti,aes(x=factor(year),y=total,fill=type,label=round(total))) + geom_bar(stat='identity') + facet_grid(.~type) + ggtitle("PM2.5 Emmisssion Baltimore") + xlab('Year') + ylab("PM2.5 Emissions ")
 
print(gplot1)
dev.copy(png,"plot3.png")
dev.off()
