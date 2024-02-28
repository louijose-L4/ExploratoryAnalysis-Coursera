library(dplyr)

data <- readRDS('./inputData/summarySCC_PM25.rds')

sset = subset(data,fips=='24510')

emiBalti <- sset %>% group_by(year) %>% summarise(total=sum(Emissions))

bplot <- barplot(emiBalti$total,names.arg=emiBalti$year,col="blue",ylim=c(0,4000),xlab="Year",ylab="Emissions",main="PM2.5 Emissions in Baltimore")
text(bplot,round(emiBalti$total),label=round(emiBalti$total),pos=3,cex=1.2)
dev.copy(png,"plot2.png")
dev.off()