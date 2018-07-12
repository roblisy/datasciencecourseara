# week 3
library(jpeg)
library(tidyverse)
library(data.table)

# Question 1
acs_idaho <- download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',
                           destfile = 'getting_cleaning_data/acs_idaho.csv')
acs_df <- read.csv(file = 'getting_cleaning_data/acs_idaho.csv', 
                   header = TRUE )
which(with(acs_df, ACR == 3 & AGS == 6))

# Question 2

jpeg_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
z <- tempfile()
download.file(jpeg_url, z ,mode="wb")
pic <- readJPEG(source = z, native = TRUE)
file.remove(z)

quantile(pic, probs = c(.3,.8))

# Question 3
# load GDP data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(dt$rankingGDP)))



