library(dplyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "Data.zip")
unzip("Data.zip")

dir <- getwd()
NEI <- readRDS(file.path(dir, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dir, "Source_Classification_Code.rds"))
NEI$year <- as.factor(NEI$year)

# Plot 6
png("plot6.png")
df <- SCC %>% filter(grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))
df1 <- NEI %>% filter(fips %in% c("24510", "06037") & SCC %in% unique(df$SCC))
city <- c("Baltimore City", "Los Angeles City")
names(city) <- c("24510", "06037")
ggplot(df1, aes(year, Emissions, fill = fips)) +
        geom_bar(stat="identity") +
        facet_grid(.~fips, labeller = labeller(fips = city)) +
        labs(title = "Motor vehicle emissions over the years in Los Angeles and Baltimore Cities") +
        theme(legend.position = "none")
dev.off()