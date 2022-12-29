
#Datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Check for percentage of NA values
x0 <- NEI$Emissions
mean(is.na(x0))


#Subset data for Baltimore
Baltimore <- subset(NEI, fips == "24510")

#Baltimore by four types of sources
library(ggplot2)
BaltimoreNR <- subset(Baltimore, type == "NON-ROAD") #subset NON-ROAD
BaltimoreNRY <- aggregate(BaltimoreNR['Emissions'], by=BaltimoreNR['year'], sum)
BaltimoreR <- subset(Baltimore, type == "ON-ROAD")#subset ON-ROAD
BaltimoreRY <- aggregate(BaltimoreR['Emissions'], by=BaltimoreR['year'], sum)
BaltimoreP <- subset(Baltimore, type == "POINT") #subset POINT
BaltimorePY <- aggregate(BaltimoreP['Emissions'], by=BaltimoreP['year'], sum)
BaltimoreNP <- subset(Baltimore, type == "NONPOINT")#subset NON-POINT
BaltimoreNPY <- aggregate(BaltimoreNP['Emissions'], by=BaltimoreNP['year'], sum)
#Baltimore_plot four types of sources
png("plot3.png")
ggplot() + 
    geom_line(data = BaltimoreNRY, aes(x = year, y = Emissions, color = "NON-ROAD")) +
    geom_line(data = BaltimoreRY, aes(x = year, y = Emissions, color = "ROAD")) +
    geom_line(data = BaltimorePY, aes(x = year, y = Emissions, color = "POINT")) +
    geom_line(data = BaltimoreNPY, aes(x = year, y = Emissions, color = "NON-POINT")) +
    xlab('Year') +
    ylab('Emissions (in tons)') + labs(title="Baltimore: Total(PM2.5) Emissions by Year/Type")+ scale_color_manual(name='Emisssion Source Type',
                                                                                                                   breaks=c('NON-ROAD', 'ROAD', 'POINT', 'NON-POINT'),
                                                                                                                   values=c('NON-ROAD'='red', 'ROAD'='blue', 'POINT'='orange', 'NON-POINT'='black'))
dev.off()