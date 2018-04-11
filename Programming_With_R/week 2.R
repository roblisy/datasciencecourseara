#control statements
x <- 4

y <- if(x>3) {10}
     else {0}

y <- list()

y <- c(1,2,5,7)
length(y)

# FOR loops
for (i in 1:length(y)){
  print(y[i])}

for (i in seq_along(y)){
    print(y[i])}

for (i in 1:4) print(y[i])

# WHILE loops
# while does logical expressions, for does a iteration
count <- 0
while (count <11){
  print(count)
  count <- count + 1}

z <- 5
list_z_hist <- list()
while (x >= 3 && z <= 10) {
  print(z)
  list_z_hist[]
  coin <- rbinom(1,1,.5)
  if (coin == 1){
      z <- z +1
  } else {
    z <-z-1}
}
  }
  
  }
}

# repeat loop - runs until it hits a break condition.
repeat {
  x1 <- computeEstimate()
  if {.....}
  else {...}
}

# NEXT - skips an iteration of a loop.
for (i in 1:100){
  if(i <= 20){
    next}
  print(i)
}


# making a function
robby <- function(x, y){
  return(x+y)
}

#greater than vector subset
above10 <- function(x){
  use <-x >10
  return(x[use])
}

above <- function(x, n=10){
  use <- x > n
  return(x[use])
}

vals <- 1:50
q <- above(vals, 20)
q2 <- above(vals)


# calculate the mean of a column..

col_mean <- function(x){
  # calcs the mean of columns on a data frame
  cols_count <- ncol(x)
  means <- numeric(cols_count)
  for (i in 1:length(cols_count)) {
    means[i] <- mean(x[,i])
  }
  
  return(means)
}
}

col_mean(airquality)

