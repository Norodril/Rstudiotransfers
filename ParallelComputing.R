library(parallel)

n_cores <- detectCores()
print(n_cores) #even if machine has 10 cores, R will use only one unless a cluster is created

#creating a cluster
cl <- makeCluster(n_cores - 1) #leaves one core free for system operations (adds to system time)
#makeCluster launches k separate R processes
#these workers can run tasks in parallel

square_function <- function(x) {
  return(x^2)
  }#defining function each core will run

#splits the work across the workers
result <- parLapply(cl, 1:10, square_function)

#shuts down the workers- terminates all 9 worker R processes and frees the cores they were using
stopCluster(cl)
print(unlist(result))

myFunc <- function(x) {
  x+2
}
print(lapply(1:10, myFunc))