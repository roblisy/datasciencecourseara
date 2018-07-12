# load libraries..
library(tidyverse)
library(ggplot2)
library(reshape2)

# testing values
num <- "best"

# create function 'rankhospital'
rankhospital <- function(st="TX", measure="heart failure", num = "best"){
  
  # read in the CSV.
  outcome <- read.csv(file = 'outcome-of-care-measures.csv', 
                    colClasses = "character")

  # do some data cleaning... (data has character values instead of NA.)
  outcome[outcome == "Not Available"] <- NA
  
  # dumb way to get only the hospital and measure in... select cols 11 / 17 / 23..
  if (measure == 'heart attack') {i <- 11
  } else if (measure == 'heart failure') {
    i <- 17
  } else if (measure == 'pneumonia') {
    i <- 23
  } else {
    stop('invalid outcome')
  }


  # select only the important columns (hospital name, state, measure) and rename them for ease of use...
  out_2 <- outcome[, c(2,7,i)]
  names(out_2)[1] <- "name"
  names(out_2)[2] <- "state"
  names(out_2)[3] <- "measure"
  
  # trap invalid states 
  if(!(st %in% out_2$state)){
    stop("invalid state")
  }
  
  # convert to numbers
  out_2$measure <- as.numeric(out_2$measure)
  out_2$name <- as.character(out_2$name)
  
  # select the relevant state and arrange
  out_2 <- out_2 %>% 
    na.omit() %>%
    filter(state == st) %>%
    arrange(measure, name)
  
  # recode the best and worst into integers... this way we can reference the row with the record..
  if (num =="best"){num <- 1}
  if (num =="worst"){num <- nrow(out_2)}
  
  if (num > nrow(out_2)){
    return(NA)
  }
  else {
    return(as.character(out_2[num, 1]))}
}

T0 <- rankhospital("TX", "heart failure", 4)
T1 <- rankhospital("MD", "heart attack", "worst")
T2 <- rankhospital("MN", "heart attack", 5000)

A1 <- rankhospital("NC", "heart attack", "worst")
A2 <- rankhospital("WA", "heart attack", 7)
A3 <- rankhospital("TX", "pneumonia", 10)
A4 <- rankhospital("NY", "heart attack", 7)
