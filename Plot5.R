#Datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Check for percentage of NA values
x0 <- NEI$Emissions
mean(is.na(x0))


#filter out Baltimore resulst and also filter for road emissions
Baltimore <- subset(NEI, fips == "24510")
RoadSCC <- subset(SCC, Data.Category == "Onroad")
subsetBaltRoad <- subset(Baltimore, SCC %in% RoadSCC$SCC)
BRoadEByYear <- aggregate(subsetBaltRoad['Emissions'], by=subsetBaltRoad['year'], sum)
options(scipen = 999)
png("plot5.png")
with(BRoadEByYear, plot(year,Emissions,pch = 16, col = "black", main = "Baltimore: Total(PM2.5) Motor Vehicle Emissions by Year", xaxt = "n", ylab = "Emissions (in tons)"))
axis(side=1, at = c(1999, 2002, 2005, 2008))
dev.off()