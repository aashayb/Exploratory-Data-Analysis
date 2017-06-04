## Reading the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data of the required area
NEIsub <- subset(x = NEI,subset = NEI$fips == "24510")

## finding sum by Year
sumByYear <- tapply(X = NEIsub$Emissions,INDEX = as.factor(NEIsub$year),FUN = sum)

png("Plot2.png")
## Ploting the graph
plot(sumByYear,type = "b", xlab = "Year",ylab = "Total Emission",xaxt = "n",main = "Annual total Emission of Baltimore City")

## Label of X axis
axis(side = 1,at = 1:length(sumByYear),labels = names(sumByYear))

dev.off()