## Reading the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## finding sum by Year
sumByYear <- tapply(X = NEI$Emissions,INDEX = as.factor(NEI$year),FUN = sum)

png("Plot1.png")
## Ploting the graph
plot(sumByYear,type = "b", xlab = "Year",ylab = "Total Emission",xaxt = "n",main = "Annual total Emission")

## Label of X axis
axis(side = 1,at = 1:length(sumByYear),labels = names(sumByYear))

dev.off()