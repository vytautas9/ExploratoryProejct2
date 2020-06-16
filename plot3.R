library(dplyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "Data.zip")
unzip("Data.zip")

dir <- getwd()
NEI <- readRDS(file.path(dir, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dir, "Source_Classification_Code.rds"))
NEI$year <- as.factor(NEI$year)

# Plot 3
png("plot3.png")
df <- NEI %>% filter(fips == "24510")
ggplot(df, aes(year, Emissions, fill = type)) + 
        geom_bar(stat = "identity") +
        facet_grid(.~type) +
        labs(title = "Emission over the years in Baltimore City by type")
dev.off()