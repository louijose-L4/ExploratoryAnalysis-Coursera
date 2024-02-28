library(dplyr)
library(ggplot2)

SCC_data <- readRDS('./inputData/Source_Classification_Code.rds')
summary_data <- readRDS('./inputData/summarySCC_PM25.rds')

####subsetting the balitmore city

sset <- subset(summary_data,fips == '24510')

### Extracting SCC codes for vehicles

ssc_vech <- SCC_data[grepl('Vehicle',SCC_data$SCC.Level.Two),]
unique_ssc <- unique(ssc_vech$SCC)

vech_data <- sset[(sset$SCC %in% unique_ssc),]

final_emi <- vech_data %>% group_by(year) %>% summarize(total= sum(Emissions))


gplot3 <- ggplot(final_emi,aes(factor(year),total,label=round(total))) + geom_bar(stat="identity",fill="blue")+ geom_text(size=4,vjust=-1) + xlab("Year") + ylab("Emissions in ton") + ggtitle("Vehicle Emissions in Baltimore city")
print(gplot3)

dev.copy(png,"plot5.png")
dev.off()



