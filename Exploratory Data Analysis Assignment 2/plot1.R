NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
NEI_year <- NEI %>% group_by(year)   #NEI_year <- group_by(NEI, year)
##summarise(NEI_year, emissions_sum = sum(NEI$Emissions)) wrong!!!
#summarise(NEI_year, emissions_sum = sum(Emissions))
total_emissions <- summarise(NEI_year, emissions_sum = sum(Emissions))
clrs = c("black","red","blue","green")
png("plot1.png")
x1<-barplot(height=total_emissions$emissions_sum, names.arg=total_emissions$year,
      xlab="years", ylab=expression('total PM'[2.5]*' emission'),ylim=c(0,8000000),
      main=expression('Total PM'[2.5]*' emissions at various years'),col=clrs)
text(x = x1, y = round(total_emissions$emissions_sum,2), 
	label = round(total_emissions$emissions_sum,2), pos = 3, cex = 0.8, col = "black")
dev.off()