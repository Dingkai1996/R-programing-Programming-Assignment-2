NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(dplyr)
NEI_Bal <- NEI %>% filter(fips == "24510")
NEI_Bal_year <- NEI_Bal %>% group_by(year)
#summarise(NEI_Bal_year, emissions_Bal_sum = sum(Emissions))
total_emissions_Bal <- summarise(NEI_Bal_year, emissions_Bal_sum = sum(Emissions))
clrs = c("black","red","blue","green")
png("plot2.png")
x2<-barplot(height=total_emissions_Bal$emissions_Bal_sum, names.arg=total_emissions_Bal$year,
      xlab="years", ylab=expression('total PM'[2.5]*' emission'),ylim=c(0,4000),
      main=expression('Total PM'[2.5]*' emissions at various years in Baltimore'),col=clrs)
text(x = x2, y = round(total_emissions_Bal$emissions_Bal_sum,2), 
	label = round(total_emissions_Bal$emissions_Bal_sum,2), pos = 3, cex = 0.8, col = "black")
dev.off()

