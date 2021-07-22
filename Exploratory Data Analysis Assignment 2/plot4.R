NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

coal_combustion <- grep("Fuel Comb.*Coal",SCC$EI.Sector) 
#coal_combustion <- grepl("Fuel Comb.*Coal",SCC$EI.Sector)
#Both are correct.

coal_combustion_data <- SCC[coal_combustion,]
coal_combustion_select <- NEI$SCC %in% coal_combustion_data$SCC
emissions_coal_combustion <- NEI[coal_combustion_select,]
emissions_coal_combustion_group <- group_by(emissions_coal_combustion,year)
total_emissions_coal_combustion <- summarise(emissions_coal_combustion_group,emissions_coal_combustion_sum = sum(Emissions)) 
png("plot4.png")
x4 <- ggplot(total_emissions_coal_combustion, aes(x= factor(year),y= emissions_coal_combustion_sum,fill=year))
x4 <- x4 + geom_bar(stat="identity")
x4 <- x4 + xlab("year") + ylab(expression("total PM"[2.5]*" emission"))
x4 <- x4 + ggtitle(expression("Total PM"[2.5]*" emission from coal-combustion"))
x4 <- x4 + theme(plot.title = element_text(hjust=0.5))
x4 <- x4 + geom_text(aes(label= round(emissions_coal_combustion_sum,2),vjust=-0.7,hjust=0.5))
x4
dev.off()








s <- function(x){
	y <- 0
	for ( i in x){
		if (i== TRUE){
			y <- y + 1
		}
	}
	y
}
