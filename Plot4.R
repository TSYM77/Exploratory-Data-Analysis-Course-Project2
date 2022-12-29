#Datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Check for percentage of NA values
x0 <- NEI$Emissions
mean(is.na(x0))

#calculate emissions from coal combustion related sources by year for entire US
library(dplyr)
#filter SCC dataframe for coal combustion related sources
subsetSCCCoal <- dplyr::filter(SCC, grepl('*Coal', EI.Sector))
#subset overall NEI dataframe using above coal-related SCC values 
subsetNEI <- subset(NEI, SCC %in% subsetSCCCoal$SCC)
subsetNEI
CEmisByYear <- aggregate(subsetNEI['Emissions'], by=subsetNEI['year'], sum)
png("plot4.png")
options(scipen = 999)
with(CEmisByYear, plot(year,Emissions,pch=16, bg="black", col="blue",cex=1, main = "US: Total (PM2.5) Coal Emissions by Year",xaxt = 'n', ylab = "Emissions (in tons)"))
axis(side=1, at = c(1999, 2002, 2005, 2008))
lines(CEmisByYear$year, CEmisByYear$Emissions, col = "black")
dev.off()