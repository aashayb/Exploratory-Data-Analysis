require(ggplot2)

## Reading the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data with the required Source Code
NEIsub <- subset(NEI,(fips == "24510" & type == "ON-ROAD"))

## finding sum by Year and Type
sumByYear <- melt(tapply(X = NEIsub$Emissions,INDEX = as.factor(NEIsub$year),FUN = sum))
names(sumByYear) <- c("Year","Emission")
  
png("Plot5.png",width = 640,height = 640)
## Making Graph
g<-ggplot(sumByYear,aes(x = Year,y = Emission)) 
g<-g+ geom_count(color="firebrick",size = 4.5)
g<-g+ geom_line(color="firebrick", linetype = "dashed")
g<-g+labs(title = "Total Emissions from motor vehicle sources in Baltimore City")
g<-g+geom_text(aes(label=round(Emission/1000,digits=2), size=2,vjust = 1))
g<-g+scale_x_continuous(breaks = as.numeric(levels(as.factor(sumByYear$Year))))
g<-g+guides(size = FALSE)

print(g)

dev.off()