library(dplyr)
library(ggplot2)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "Data.zip")
unzip("Data.zip")

dir <- getwd()
NEI <- readRDS(file.path(dir, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dir, "Source_Classification_Code.rds"))
NEI$year <- as.factor(NEI$year)

# Plot 4
png("plot4.png")
df <- SCC %>% filter(grepl("combust", SCC.Level.One, ignore.case = TRUE)) %>%
        filter(grepl("coal", SCC.Level.Four, ignore.case = TRUE))
df1 <- NEI %>% filter(SCC %in% unique(df$SCC))
ggplot(df1, aes(year, Emissions)) + 
        geom_bar(stat="identity", fill = "orange") +
        labs(title = "Coal combustion-related emissions over the years in U.S.")
dev.off()