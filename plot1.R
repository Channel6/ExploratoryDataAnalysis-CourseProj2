#### Exploratory Data Analysis -- Course Project 2 ###
##			Glenn Kerbein		    ##
##		      February 20, 2017		    ##
##		           Plot 1		    ##
######################################################

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

