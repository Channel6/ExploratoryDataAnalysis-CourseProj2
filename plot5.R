#### Exploratory Data Analysis -- Course Project 2 ###
##			Glenn Kerbein		    ##
##		      February 20, 2017		    ##
##		           Plot 5		    ##
######################################################

## intiailaize data requirements
## put all plots in this main plotting.R file, and output the
### individual plots as needed
library(plyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

NEI.motor.24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]

aggregate.motor.24510 <- with(
	NEI.motor.24510,
	aggregate(
		Emissions,
		by = list(year), 
		sum
	)
)

png(
	filename="plot5.png",
	width=504,
	height=504,
	units="px"
)

plot(
	aggregate.motor.24510,
	type = "o",
	ylab = expression("Total Emissions, PM"[2.5]),
	xlab = "Year",
	main = "Total Emissions from Motor Vehicle Sources"
)
