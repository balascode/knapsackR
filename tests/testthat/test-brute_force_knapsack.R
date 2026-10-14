
test_that("brute_force_knapsack returns the correct optimal solution", {

  x <- data.frame(
    w = c(1, 3, 4),
    v = c(1, 4, 5)
  )

  result <- brute_force_knapsack(x, W = 5)

  expect_equal(result$value, 6)
  expect_equal(result$elements, c(1L, 3L))
})


test_that("brute_force_knapsack works when one item fits", {

  x <- data.frame(
    w = 3,
    v = 10
  )

  result <- brute_force_knapsack(x, W = 3)

  expect_equal(result$value, 10)
  expect_equal(result$elements, 1L)
})


test_that("brute_force_knapsack returns no elements when all items are too heavy", {

  x <- data.frame(
    w = c(5, 6, 7),
    v = c(10, 20, 30)
  )

  result <- brute_force_knapsack(x, W = 4)

  expect_equal(result$value, 0)
  expect_equal(result$elements, integer())
})


test_that("brute_force_knapsack chooses the best combination", {

  x <- data.frame(
    w = c(2, 3, 5),
    v = c(6, 10, 15)
  )

  result <- brute_force_knapsack(x, W = 5)

  expect_equal(result$value, 16)
  expect_equal(result$elements, c(1L, 2L))
})


test_that("brute_force_knapsack returns a list with value and elements", {

  x <- data.frame(
    w = c(1, 2),
    v = c(5, 10)
  )

  result <- brute_force_knapsack(x, W = 2)

  expect_type(result, "list")
  expect_named(result, c("value", "elements"))
})


test_that("brute_force_knapsack rounds the maximum value", {

  x <- data.frame(
    w = c(1, 2),
    v = c(5.7, 10.6)
  )

  result <- brute_force_knapsack(x, W = 3)

  expect_equal(result$value, 16)
  expect_equal(result$elements, c(1L, 2L))
})


test_that("brute_force_knapsack works with an empty data.frame", {

  x <- data.frame(
    w = numeric(),
    v = numeric()
  )

  result <- brute_force_knapsack(x, W = 5)

  expect_equal(result$value, 0)
  expect_equal(result$elements, integer())
})


test_that("brute_force_knapsack rejects input that is not a data.frame", {

  x <- matrix(c(1, 2, 3, 4), ncol = 2)

  expect_error(
    brute_force_knapsack(x, W = 5),
    "x must be a data.frame"
  )
})


test_that("brute_force_knapsack requires w and v columns", {

  x <- data.frame(
    weight = c(1, 2),
    value = c(5, 10)
  )

  expect_error(
    brute_force_knapsack(x, W = 5),
    "x must contain columns named 'w' and 'v'"
  )
})


test_that("brute_force_knapsack rejects non-positive weights or values", {

  x_negative_weight <- data.frame(
    w = c(1, -2),
    v = c(5, 10)
  )

  expect_error(
    brute_force_knapsack(x_negative_weight, W = 5),
    "Weights and values must be positive"
  )

  x_zero_value <- data.frame(
    w = c(1, 2),
    v = c(5, 0)
  )

  expect_error(
    brute_force_knapsack(x_zero_value, W = 5),
    "Weights and values must be positive"
  )
})


test_that("brute_force_knapsack rejects invalid W", {

  x <- data.frame(
    w = c(1, 2),
    v = c(5, 10)
  )

  expect_error(
    brute_force_knapsack(x, W = 0),
    "W must be a single positive numeric value"
  )

  expect_error(
    brute_force_knapsack(x, W = -1),
    "W must be a single positive numeric value"
  )

  expect_error(
    brute_force_knapsack(x, W = "five"),
    "W must be a single positive numeric value"
  )

  expect_error(
    brute_force_knapsack(x, W = c(5, 6)),
    "W must be a single positive numeric value"
  )

  expect_error(
    brute_force_knapsack(x, W = Inf),
    "W must be a single positive numeric value"
  )
})


test_that("brute_force_knapsack never exceeds the capacity", {

  x <- data.frame(
    w = c(2, 3, 4, 5),
    v = c(4, 7, 9, 10)
  )

  result <- brute_force_knapsack(x, W = 6)

  expect_lte(sum(x$w[result$elements]), 6)
  expect_equal(result$value, round(sum(x$v[result$elements])))
})
