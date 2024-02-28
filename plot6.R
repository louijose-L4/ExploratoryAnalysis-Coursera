library(dplyr)
library(ggplot2)

# reading the data
summary_data <- readRDS('./inputData/summarySCC_PM25.rds')

SCC_data <- readRDS('./inputData/Source_Classification_Code.rds')

# filtering the baltimore and LA

sset <- subset(summary_data,(fips == "06037"|fips == "24510"))

#Identify vechiles in classification code

vech_data <- SCC_data[grepl('Vehicle',SCC_data$SCC.Level.Two),]

# identify unique SCC code
unique_vech <- unique(vech_data$SCC)

vech_data2 <- sset[(sset$SCC %in% unique_vech),] 

emi_balti_LA <- vech_data2 %>% group_by(fips,year) %>% summarize(total=sum(Emissions))

#Naming the baltimore and LA to highlight in the plot
balti_LA_year <- mutate(emi_balti_LA, 
                        Unit = ifelse(fips == "24510", "Baltimore City",ifelse(fips == "06037", "Los Angeles County")))

gplot4 <- ggplot(balti_LA_year,aes(factor(year),total,fill=Unit,label=round(total))) + geom_bar(stat="identity") + facet_grid(. ~ Unit) + geom_text(size=4,vjust=-1) + xlab("Year") + ylab("Emissions") + ggtitle("PM2.5 Vehicle Emissions in Baltimore & LA")
print(gplot4)
dev.copy(png,"plot6.png")
dev.off()