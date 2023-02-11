# ADD A DAY CYCLE CAP

monte_carlo <- function(n, tasks, data) {
  i <- 1
  output <- c()
  while (i <= n) {
    total <- 0
    y <- 1
    while (y <= tasks) {
      picked <- sample(data, 1)
      total <- total + picked
      y <- y + 1
    }
    output <- append(output, total)
    i <- i + 1
  }
  return(output)
}

n <- 1000
tasks <- 70
# devs <- 6
# days_left <- 47
data <- c(1, 3, 5)

distribution <- monte_carlo(n, tasks, data)