# week 4

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "cameras.csv", method = "curl")
cameraData <- read.csv(file = 'cameras.csv')
names(cameraData)


tolower(names(cameraData))
#splitNames = strsplit(names(cameraData), "\\.\")

# Week 4 quiz

fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
tmp_file <- tempfile()
download.file(url = fileurl, destfile = tmp_file)

q1_df <- read.csv(tmp_file) 

View(head(q1_df, n=5))

# answer 1
strsplit(x = names(q1_df), split = 'wgtp')

# Question 2

fileurl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
tmp_file <- tempfile()
download.file(url = fileurl2, destfile = tmp_file)

q2_df <- read.csv(file = tmp_file)
#names(q2_df)
q2_df <- q2_df %>%
  slice(5:195)

gdp <- as.numeric(gsub(",","", q2_df$X.3))
mean(gdp, na.rm = TRUE)
mean(gdp)
