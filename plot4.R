#### Exploratory Data Analysis -- Course Project 2 ###
##			Glenn Kerbein		    ##
##		      February 20, 2017		    ##
##		           Plot 4		    ##
######################################################

## intiailaize data requirements
## put all plots in this main plotting.R file, and output the
### individual plots as needed
library(plyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## plot 4
SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

aggregate.coal <- with(
	NEI.coal,
	aggregate(
		Emissions,
		by = list(year),
		sum
	)
)
colnames(aggregate.coal) <- c("year", "Emissions")

png(
	filename="plot4.png",
	width=504,
	height=504,
	units="px"
)

plot(
	aggregate.coal,
	type = "o",
	ylab = expression("Total Emissions, PM"[2.5]), 
	xlab = "Year",
	main = "Emissions and Total Coal Combustion for the United States", 
	xlim = c(1999, 2008)
)

polygon(aggregate.coal, col = "red", border = "red")

