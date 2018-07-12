# Getting and Cleaning data Coursera (4 week class)

setwd('/Users/bmsf/Projects/datasciencecourseara/getting_cleaning_data/')
library(tidyverse)
library(openxlsx)
library(XML)
library(methods)
library(plyr)
acs_idaho <- read.csv(file = 'american_community_survey.csv', header = TRUE, sep = ',')

# Question 1 and kinda 2
question_1 <- acs_idaho %>% filter(VAL >= 24)

head(acs_idaho, n = 1)

# Question 3
dat <- read.xlsx(xlsxFile = 'natural_gas_acquistion_program.xlsx', 
                     sheet = 'NGAP Sample Data', 
                     rows =  c(18:23),
                     cols = c(7:15))

# Answer 3
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4

baltimore_restaurants <- xmlParse(file = 'balitmore_restaurants.xml', 
                                  trim = TRUE, 
                                  useInternalNodes = TRUE)
baltimore_restaurants_df <- xmlToDataFrame(b2)

# playing with XML parsing below...
xmltop <- xmlRoot(b2)
class(xmltop)
xmlName(xmltop)
xmlSize(xmltop)
xmlName(xmltop[[1]])
xmltop[[2]]

xmlSize(xmltop[[1]])

# looks like we only have to go one level down in this XML strucutre.

