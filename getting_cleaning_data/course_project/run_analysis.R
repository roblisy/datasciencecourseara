# Getting and Cleaning Data course project submission
library(tidyverse)
library(data.table)
library(downloader)
library(reshape2)

# download, unzip the data, and put it into a data frame.
zip_file <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download(url = zip_file, dest = 'dataset.zip', mode = "wb")
unzip ('dataset.zip', exdir = "./")

# looks like we have a folder with many files underneath it.

# lets load the test data, then the train data.
subject_test <- read.table(file = 'UCI HAR Dataset/test/subject_test.txt')
x_test <- read.table(file = 'UCI HAR Dataset/test/X_test.txt')
y_test <- read.table(file = 'UCI HAR Dataset/test/y_test.txt')

subject_train <- read.table(file = 'UCI HAR Dataset/train/subject_train.txt')
x_train <- read.table(file = 'UCI HAR Dataset/train/X_train.txt')
y_train <- read.table(file = 'UCI HAR Dataset/train/y_train.txt')

# load activity labels and features as dimensions.
activity <- read.table(file = 'UCI HAR Dataset/activity_labels.txt')
features <- read.table(file = 'UCI HAR Dataset/features.txt')

# Question 1 - generate 1 data set (combine test and train.)
# merge test and train sets.
x_complete <- rbind(x_test, x_train)
y_complete <- rbind(y_test, y_train)

# Question 2 - only grab the std and mean columns
# make a vector to grab only the columns with 'mean' and 'std' in their names
keep_features <- grep("std()|mean()", features[,2])

# remove the columns from X that aren't mean / std
x_complete <- x_complete[ ,keep_features]

# Question 3 - add nice activity names
y_complete <- left_join(x = y_complete,
                        y = activity,
                        by = c('V1', 'V1'))

complete <- cbind(y_complete, x_complete)

# Question 4 - Add nice labels to the columns with descriptive variable names.
# I'll remove the parenthesis for this, they're ugly.
nicenames <- sapply(features[,2], 
                    function(x){gsub("[()]","", x)})
nicenames <- nicenames[keep_features]
names(complete) <- c('activity_code', 'activity_description', nicenames)
View(head(complete, n=20))
