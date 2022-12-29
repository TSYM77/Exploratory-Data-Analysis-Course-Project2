#Datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Check for percentage of NA values
x0 <- NEI$Emissions
mean(is.na(x0))


Baltimore <- subset(NEI, fips == "24510")
RoadSCC <- subset(SCC, Data.Category == "Onroad")
subsetBaltRoad <- subset(Baltimore, SCC %in% RoadSCC$SCC)
BRoadEByYear <- aggregate(subsetBaltRoad['Emissions'], by=subsetBaltRoad['year'], sum)

LACounty <- subset(NEI, fips == "06037")
RoadSCC <- subset(SCC, Data.Category == "Onroad")
subsetLARoad <- subset(LACounty, SCC %in% RoadSCC$SCC)
LARoadEByYear <- aggregate(subsetLARoad['Emissions'], by=subsetLARoad['year'], sum)
options(scipen = 999)

png("plot6.png")
par(mfrow=c(1,2))
LA <- with(LARoadEByYear, plot(year,Emissions,main="LA County", ylab = "Motor Vehicle Emissions (in tons)", xaxt = 'n', yaxt = 'n', ylim=c(0,5000)))
axis(side=1, at = c(1999, 2002, 2005, 2008))
Balt <- with(BRoadEByYear, plot(year,Emissions,main="Baltimore",pch = 16,col="black",ylab ="Motor Vehicle Emissions (in tons)", xaxt = 'n', yaxt = 'n', ylim=c(0,5000)))
axis(side=1, at = c(1999, 2002, 2005, 2008))
dev.off()
