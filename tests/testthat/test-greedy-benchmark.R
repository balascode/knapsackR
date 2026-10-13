# Generate the test data from Lab 6
RNGversion(min(as.character(getRversion()), "3.5.3"))

set.seed(
  42,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion"
)

n <- 1000000

knapsack_objects <- data.frame(
  w = sample(1:4000, size = n, replace = TRUE),
  v = runif(n = n, 0, 10000)
)

# Measure how long the greedy algorithm takes
execution_time <- system.time(
  result <- greedy_knapsack(
    x = knapsack_objects,
    W = 3500
  )
)

# Show the execution time and result
print(execution_time)
print(result)
