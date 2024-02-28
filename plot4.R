library(dplyr)
library(ggplot2)

SCC_data <- readRDS('./inputData/Source_Classification_Code.rds')
summary_data <- readRDS('./inputData/summarySCC_PM25.rds')

coal_data <- SCC_data[grepl('Comb.*Coal',SCC_data$Short.Name),]
unique_scc <- unique(coal_data$SCC)
summary_scc <- summary_data[(summary_data$SCC %in% unique_scc),]
coal_emi <- summary_scc %>% group_by(year) %>% summarize(total=sum(Emissions))

gplot2 = ggplot(coal_emi,aes(factor(year),total/1000,label=round(total/1000))) + geom_bar(stat="identity",fill='red') + xlab("Year") + ylab("PM2.5 Emissions") + ggtitle("Coal combustion related PM2.5 Emissions") + ylim(c(0, 620)) + geom_text(size = 5, vjust = -1) + theme_gray() 

print(gplot2)  
dev.copy(png,'plot4.png')
dev.off()

