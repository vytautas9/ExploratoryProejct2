library(dplyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "Data.zip")
unzip("Data.zip")

dir <- getwd()
NEI <- readRDS(file.path(dir, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dir, "Source_Classification_Code.rds"))
NEI$year <- as.factor(NEI$year)

# Plot 5
png("plot5.png")
df <- SCC %>% filter(grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))
df1 <- NEI %>% filter(fips == "24510" & SCC %in% unique(df$SCC))
ggplot(df1, aes(year, Emissions)) +
        geom_bar(stat="identity", fill="#FF5500") +
        labs(title = "Motor vehicle emissions over the years in Baltimore City")
dev.off()