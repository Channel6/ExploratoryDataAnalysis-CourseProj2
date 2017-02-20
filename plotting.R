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

BatltimoreMD.type <- ddply(
	BatltimoreMD,
	.(type, year),
	summarize,
	Emissions = sum(Emissions)
)
BatltimoreMD.type$Pollutant_Type <- NEI.24510.type$type

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


