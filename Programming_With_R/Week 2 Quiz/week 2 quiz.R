library(tidyverse)
library(lubridate)

# function which accepts the directory, pollutant name, and sensor ID
# the function should:
#   - left append zeros to ID so it's 3 chars wide
#   - loop through each file and open them (read.csv())
#   - store results into the list object

pollutantmean <- function(dir, pol, id){
  # make a data frame
  df <- data.frame()
  # left pad zeros...
  id <- formatC(id, width = 3, format = "d", flag = "0")
  # for loop to go through the files.
  for (i in 1:length(id)){
    #print(paste0("Loading ", paste0(dir,"/", id[i], ".csv"),"..."))
    dat <- read.csv(file = paste0(dir,"/", id[i], ".csv"), 
                           header = TRUE, 
                           sep = ',',
                           stringsAsFactors = FALSE)
    dat$i <- i #column which contains source for the run.
    df <- bind_rows(dat, df)
  }
  df$Date <- ymd(df$Date)
  return(mean(df[ ,pol], na.rm = TRUE))
}

pol_val <- pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)

complete <- function(directory, id){
  df <- data.frame()
  id <- formatC(id, width = 3, format = "d", flag = "0")
  
  for (i in 1:length(id)){
  f <- read.csv(file = paste0(directory, "/", id[i], ".csv"),
                header = TRUE, 
                sep = ",", 
                stringsAsFactors = FALSE)
  df <- bind_rows(f, df)
  }
  df$Date <- ymd(df$Date)
  df_2 <- df %>% 
            na.omit() %>%
            group_by(ID) %>%
            summarize(nobs=n())
  return(df_2)
}

c1 <- complete("specdata", 1)
c2 <- complete("specdata", c(2, 4, 8, 10, 12))
c3 <- complete("specdata", 30:25)
c4 <- complete("specdata", 3)

corr <- function(directory, threshold = 0) {
  
  tcorr <- function(fname) {
    data <- read.csv(file.path(directory, fname))
    nobs <- sum(complete.cases(data))
    if (nobs > threshold) {
      return (cor(data$nitrate, data$sulfate, use="complete.obs"))
    }
  }
  
  tcorrs <- sapply(list.files(directory), tcorr) #get all correlations + NULLs
  tcorrs <- unlist(tcorrs[!sapply(tcorrs, is.null)]) #remove NULLs
  
  return (tcorrs)
}
cr <- corr("specdata", 150)
head(cr)
