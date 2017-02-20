#### Exploratory Data Analysis -- Course Project 2 ###
##			Glenn Kerbein		    ##
##			February 20, 2017	    ##
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

## plot 5
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

## plot 6
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

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

NEI.motor.24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]
NEI.motor.06037 <- NEI.motor[which(NEI.motor$fips == "06037"), ]

aggregate.motor.24510 <- with(
	NEI.motor.24510,
	aggregate(
		Emissions,
		by = list(year), 
		sum
	)
)
aggregate.motor.24510$group <- rep(
	"Baltimore County",
	length(aggregate.motor.24510[, 1])
)


aggregate.motor.06037 <- with(
	NEI.motor.06037,
	aggregate(Emissions, by = list(year),
	sum
	)
)
aggregate.motor.06037$group <- rep(
	"Los Angeles County",
	 length(aggregate.motor.06037[, 1])
)

aggregated.motor.zips <- rbind(
	aggregate.motor.06037,
	aggregate.motor.24510
)
aggregated.motor.zips$group <- as.factor(aggregated.motor.zips$group)

colnames(aggregated.motor.zips) <- c("Year", "Emissions", "Group")


png(
	filename="plot6.png",
	width=504,
	height=504,
	units="px"
)

qplot(
	Year,
	Emissions,
	data = aggregated.motor.zips,
	group = Group,
	color = Group,
	geom = c("point", "line"),
	ylab = expression("Total Emissions, PM"[2.5]), 
	xlab = "Year",
	main = "Comparison of Total Emissions by County"
)
