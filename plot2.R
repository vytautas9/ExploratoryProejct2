library(dplyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "Data.zip")
unzip("Data.zip")

dir <- getwd()
NEI <- readRDS(file.path(dir, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dir, "Source_Classification_Code.rds"))
NEI$year <- as.factor(NEI$year)

# Plot 2
png("plot2.png")
df <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarise(Total = sum(Emissions))
Total2 <- df$Total
names(Total2) <- df$year
barplot(Total2)
title(main = "Emissions over the years in Baltimore City", xlab = "Year", ylab = "Emissions")
dev.off()