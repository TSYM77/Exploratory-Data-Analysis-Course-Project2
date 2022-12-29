#Datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Check for percentage of NA values
x0 <- NEI$Emissions
mean(is.na(x0))

#calculate emissions by year for entire US
EmisByYear <- aggregate(NEI['Emissions'], by=NEI['year'], sum)
png("plot1.png")
options(scipen = 999)
with(EmisByYear, plot(year,Emissions, pch=21, bg="yellow", col="red",cex=2, main = "US: Total (PM2.5) Emissions by Year",xaxt = 'n', ylab = "Emissions (in tons)"))
axis(side=1, at = c(1999, 2002, 2005, 2008))
lines(EmisByYear$year, EmisByYear$Emissions, col = "black")
dev.off()


