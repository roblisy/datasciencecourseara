library(reshape2)
library(tidyverse)
library(ggplot2)

# Part 1
outcome <- read.csv(file = 'outcome-of-care-measures.csv', 
                    colClasses = "character")
head(outcome)
ncol(outcome)
names(outcome)

# make a histogram
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

# do some data cleaning... (data has character values instead of NA.)
outcome[outcome == "Not Available"] <- NA
# subset this data...
out_2 <- outcome %>% 
  select(name = Hospital.Name, 
         state = State, 
         heart_attack = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, 
         heart_failure = Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, 
         pneumonia = Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)

# convert to numbers
out_2$heart_attack <- as.numeric(out_2$heart_attack)
out_2$heart_failure <- as.numeric(out_2$heart_failure)
out_2$pneumonia <- as.numeric(out_2$pneumonia)
out_2$name <- as.factor(out_2$name)

# Find best hospital in a state.
best <- function(st = "TX", measure = "heart_attack"){
  
  if(!(st %in% out_2$state)){
    stop("invalid state")
  }
  if(!(measure %in% c("heart_attack", "heart_failure", "pneumonia"))){
    stop("invalid outcome")
  }
  res <- data.frame()
  res <- out_2 %>%
          filter(state == st) %>%
          arrange_(measure, "name")
  
  return(head(as.character(res$name), n=1))
}

# tests...
T1 <- best("TX", "heart_attack")
T2 <- best("TX", "heart_failure")
T3 <- best("MD", "heart_attack")
T4 <- best("MD", "pneumonia")
T5 <- best("BB", "heart_attack")
T6 <- best("NY", "hert_attack")

# tests pass, answer the quiz questions
A1 <- best("SC", "heart_attack")
A2 <- best("NY", "pneumonia")
A3 <- best("AK", "pneumonia")

