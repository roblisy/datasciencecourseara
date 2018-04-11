# week 2 quiz / assignment

#Part 1
# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) 
# across a specified list of monitors. The function 'pollutantmean' takes three arguments: 
# 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' 
# particulate matter data from the directory specified in the 'directory' argument and 
# returns the mean of the pollutant across all of the monitors, ignoring any 
# missing values coded as NA. A prototype of the function is as follows

id <- 1:5
dir <- "specdata"

# left pad the ID
id <- formatC(id, width = 3, format = "d", flag = "0")

# read in one file....
q <- read.csv2(file = paste0(dir,"/", id, ".csv"), 
          header = TRUE, 
          sep = ',')
# make a list to contain the IDs
id_list <- list()

#left pad the IDs in the list with 00s if needed
df <- data.frame()
pollutantmean <- function(dir, polutant, id){
  id_list <- formatC(id, width = 3, format = "d", flag = "0")
  
  # print(paste0(dir,"/",id,".csv"))
  # prepend zeros...
  for (i in 1:length(id_list)){
    print(paste0("Loading ", paste0(dir,"/", id_list[i], ".csv"),"..."))
    f <- read.csv2(file = paste0(dir,"/", id_list[i], ".csv"), 
                   header = TRUE, 
                   sep = ',')
    # append the data frame...
    rbind(f, df)
    #m <- mean(x = f$polutant, na.rm = TRUE)
  }
  return(df)
}
