require(ggplot2)

## Reading the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data of the required area
NEIsub <- subset(x = NEI,subset = (NEI$fips == "24510"|fips == "06037") & type == "ON-ROAD")

## finding sum by Year and Type
sumByYnT <- melt(tapply(X = NEIsub$Emissions,INDEX = list(as.factor(NEIsub$year),as.factor(NEIsub$fips)),FUN = sum))
names(sumByYnT) <- c("Year","fips","Emission")
sumByYnT$fips<-as.character(sumByYnT$fips)
  
png("Plot6.png",width = 640,height = 640)
## Making Graph
g<-ggplot(sumByYnT,aes(x = Year,y = Emission)) 
g<-g+ geom_count(aes(color = fips),size = 4.5)
g<-g+ geom_line( aes(color = fips),linetype = "dashed")
g<-g+labs(title = "Emissions from motor vehicle sources in Baltimore City and Los Angeles County")
g<-g+scale_x_continuous(breaks = as.numeric(levels(as.factor(sumByYnT$Year))))

print(g)

dev.off()