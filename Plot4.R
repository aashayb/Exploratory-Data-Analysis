require(ggplot2)

## Reading the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting the data with the required Source Code
subSCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),1]
subNEIcoalEm <- NEI[NEI$SCC %in% subSCCcoal,c("year","Emissions")]

## finding sum by Year and Type
sumByYear <- melt(tapply(X = subNEIcoalEm$Emissions,INDEX = as.factor(subNEIcoalEm$year),FUN = sum))
names(sumByYear) <- c("Year","Emission")
  
png("Plot4.png",width = 640,height = 640)
## Making Graph
g<-ggplot(sumByYear,aes(x = Year,y = Emission)) 
g<-g+ geom_count(color="magenta",size = 4.5)
g<-g+ geom_line(color="magenta", linetype = "dashed")
g<-g+labs(title = "Total Emission from coal combustion-related Sources")
g<-g+geom_text(aes(label=round(Emission/1000,digits=2), size=2,vjust = 1))
g<-g+scale_x_continuous(breaks = as.numeric(levels(as.factor(sumByYear$Year))))
g<-g+guides(size = FALSE)

print(g)

dev.off()