#### Exploratory Data Analysis -- Course Project 2 ###
##			Glenn Kerbein		    ##
##			February 20, 2017	    ##
######################################################\

## intiailaize data requirements
## put all plots in this main plotting.R file, and output the
### individual plots as needed
library(plyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## first plot
aggregate.data <- with(
	NEI,
	aggregate(
		Emissions,
		by = list(year),
		sum
	)
)
png(
	filename="plot1.png",
	width=504,
	height=504,
	units="px"
)
plot(
	aggregate.data,
	type = "o",
	ylab = expression("Total Emissions, PM"[2.5]),
	xlab = "Year",
	main = "Total Emissions in the US"
)
polygon(aggregate.data, col = "green", border = "blue")

## second plot
BatltimoreMD <- NEI[which(NEI$fips == "24510"), ]
aggregate.24510 <- with(
	BatltimoreMD,
	aggregate(
		Emissions,
		by = list(year),
		sum
	)
)
colnames(aggregate.24510) <- c("year", "Emissions")
png(
	filename="plot2.png",
	width=504,
	height=504,
	units="px"
)
plot(
	aggregate.24510,
	type = "o",
	ylab = expression("Total Emissions, PM"[2.5]), 
	xlab = "Year",
	main = "Total Emissions for Baltimore County",
	xlim = c(1999, 2008)
)

## third plot

BatltimoreMD <- NEI[which(NEI$fips == "24510"), ]
aggregate.24510 <- with(
	BatltimoreMD,
	aggregate(
		Emissions,
		by = list(year),
		sum
	)
)
colnames(aggregate.24510) <- c("year", "Emissions")

NEI.24510.type <- ddply(NEI.24510, .(type, year), summarize, Emissions = sum(Emissions))
NEI.24510.type$Pollutant_Type <- NEI.24510.type$type

qplot(year, Emissions, data = NEI.24510.type, group = Pollutant_Type, color = Pollutant_Type, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

