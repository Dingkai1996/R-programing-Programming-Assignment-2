NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
total_moto_emission <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
names(total_moto_emission)[2] <- "County"
total_moto_emission_Bal <- total_moto_emission %>% filter(County=="24510")
total_moto_emission_LA <- filter(total_moto_emission, County=="06037")
total_moto_emission_Bal$County <- "Baltimore, MD"
total_moto_emission_LA$County <- "Los Angeles, CA"
both_moto_emission <- rbind(total_moto_emission_Bal,total_moto_emission_LA) 

png("plot6.png", width=960, height=480)
x6 <- ggplot(both_moto_emission, aes(x=factor(year), y=Emissions, fill=County))
x6 <- x6 + geom_bar(stat="identity")+ facet_grid(.~County)
x6 <- x6 + xlab("year") + ylab(expression("total PM"[2.5]*" emission"))
x6 <- x6 + ggtitle(expression("Total PM"[2.5]*" emission of moto vehicle(ON-ROAD) type for 2 County"))
x6 <- x6 + theme(plot.title = element_text(hjust=0.5))
x6 <- x6 + geom_text(aes(label=round(Emissions,2), vjust=-0.7, hjust= 0.5))
x6
dev.off()


