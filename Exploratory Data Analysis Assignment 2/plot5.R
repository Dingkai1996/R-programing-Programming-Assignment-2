NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
library(ggplot2)

NEI_Bal <- NEI %>% filter(fips== "24510")
NEI_Bal_moto <- filter( NEI_Bal, type == "ON-ROAD")
NEI_Bal_moto_group <- group_by(NEI_Bal_moto,year)
NEI_Bal_moto_emissions <- summarise(NEI_Bal_moto_group,Bal_moto_emissions_sum= sum(Emissions)) 

png("plot5.png")
x5 <- ggplot(NEI_Bal_moto_emissions,aes(x=factor(year),y=Bal_moto_emissions_sum,fill=year))
x5 <- x5 + geom_bar(stat="identity")
x5 <- x5 + xlab("year") + ylab(expression("total PM"[2.5]*" emission"))
x5 <- x5 + ggtitle(expression("Total PM"[2.5]*" emission of motor vehicle(ON-ROAD) type in Baltimore"))
x5 <- x5 + theme(plot.title = element_text(hjust=0.5))
x5 <- x5 + geom_text(aes(label = round(Bal_moto_emissions_sum,2),vjust=-0.7,hjust=0.5))
x5
dev.off()
