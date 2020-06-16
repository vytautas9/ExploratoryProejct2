library(dplyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "Data.zip")
unzip("Data.zip")

dir <- getwd()
NEI <- readRDS(file.path(dir, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dir, "Source_Classification_Code.rds"))
NEI$year <- as.factor(NEI$year)

# Plot 1
png("plot1.png")
Total1 <- tapply(NEI$Emissions, NEI$year, sum)
barplot(Total1)
title(main = "Emissions over the years", xlab = "Year", ylab = "Emissions")
dev.off()