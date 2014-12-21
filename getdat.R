#download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
#              "dat.csv.bz2",method="wget")
storm_data  <- read.csv(bzfile(dest,open = 'r'), header=TRUE)
dat         <- storm_data[, c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "CROPDMG")]
dat$EVTYPE  <- as.factor(tolower(dat$EVTYPE))
#
fatality_n  <- tapply(dat$FATALITIES, dat$EVTYPE, sum, na.rm = TRUE)
injury_n    <- tapply(dat$INJURIES, dat$EVTYPE, sum, na.rm = TRUE)
propdamage  <- tapply(dat$PROPDMG, dat$EVTYPE, sum , na.rm = TRUE)
cropdamage  <- tapply(dat$CROPDMG, dat$EVTYPE, sum , na.rm = TRUE)
#
fatality_10 <- sort(fatality_n, decreasing =  TRUE)[1:10]
injury_10   <- sort(injury_n, decreasing =  TRUE)[1:10]
propdam_10  <- sort(propdamage, decreasing = TRUE)[1:10]
cropdam_10  <- sort(cropdamage, decreasing = TRUE)[1:10]
library(ggplot2)
fatality_names <- as.factor(names(fatality_10))
fatality_plot  <- qplot(x = fatality_names, y = fatality_10, fill = fatality_names, geom="bar", stat="identity", 
      ylab="", xlab="", main = "Top 10 Fatalities by event type")
injury_names   <- as.factor(names(injury_10))
injury_plot    <- qplot(x = injury_names, y = injury_10, fill = injury_names, geom="bar", stat="identity", 
      ylab="", xlab="", main = "Top 10 Injury by event type") 
grid.arrange(fatality_plot, injury_plot, ncol = 2)

propdam_names <- as.factor(names(propdam_10))
propdam_plot  <- qplot(x = propdam_names, y = propdam_10, fill = propdam_names, geom="bar", stat="identity", 
                        ylab="", xlab="", main = "Top 10 property damge by event type")
cropdam_names   <- as.factor(names(cropdam_10))
cropdam_plot    <- qplot(x = cropdam_names, y = cropdam_10, fill = cropdam_names, geom="bar", stat="identity", 
                        ylab="", xlab="", main = "Top 10 crop damage by event type") 
grid.arrange(propdam_plot, cropdam_plot, ncol = 2)

