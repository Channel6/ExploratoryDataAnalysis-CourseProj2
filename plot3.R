#### Exploratory Data Analysis -- Course Project 2 ###
##			Glenn Kerbein		    ##
##		      February 20, 2017		    ##
##		           Plot 3		    ##
######################################################

## intiailaize data requirements
## put all plots in this main plotting.R file, and output the
### individual plots as needed
library(plyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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

BatltimoreMD.type <- ddply(
	BatltimoreMD,
	.(type, year),
	summarize,
	Emissions = sum(Emissions)
)
BatltimoreMD.type$Pollutant_Type <- BatltimoreMD.type$type

png(
	filename="plot3.png",
	width=504,
	height=504,
	units="px"
)

qplot(
	year,
	Emissions,
	data = BatltimoreMD.type,
	group = Pollutant_Type,
	color = Pollutant_Type,
	geom = c("point", "line"),
	ylab = expression("Total Emissions, PM"[2.5]), 
	xlab = "Year",
	main = "Total Emissions in U.S. by Type of Pollutant"
)
