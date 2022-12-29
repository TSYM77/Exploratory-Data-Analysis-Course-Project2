#Datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Check for percentage of NA values
x0 <- NEI$Emissions
mean(is.na(x0))


#Subset data for Baltimore
Baltimore <- subset(NEI, fips == "24510")
#calculate emissions by year for Baltimore
BaltEmisByYear <- aggregate(Baltimore['Emissions'], by=Baltimore['year'], sum)
png("plot2.png")
options(scipen = 999)
with(BaltEmisByYear, plot(year,Emissions,pch=21, bg="black", col="red",cex=2, main = "Baltimore: Total (PM2.5) Emissions by Year", xaxt ='n', ylab = "Emissions (in tons)"))
axis(side=1, at = c(1999, 2002, 2005, 2008))
lines(BaltEmisByYear$year, BaltEmisByYear$Emissions, col = "black")
dev.off()