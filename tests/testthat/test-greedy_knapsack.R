test_that("greedy_knapsack returns a valid solution", {

  x <- data.frame(
    w = c(1, 3, 4),
    v = c(1, 4, 5)
  )

  result <- greedy_knapsack(x, W = 5)

  expect_type(result, "list")
  expect_named(result, c("value", "elements"))

  expect_lte(sum(x$w[result$elements]), 5)
  expect_equal(result$value, sum(x$v[result$elements]))
})


test_that("greedy_knapsack works when one item fits", {

  x <- data.frame(
    w = 3,
    v = 10
  )

  result <- greedy_knapsack(x, W = 3)

  expect_equal(result$value, 10)
  expect_equal(result$elements, 1L)
})


test_that("greedy_knapsack returns no elements when all items are too heavy", {

  x <- data.frame(
    w = c(5, 6, 7),
    v = c(10, 20, 30)
  )

  result <- greedy_knapsack(x, W = 4)

  expect_equal(result$value, 0)
  expect_equal(result$elements, integer())
})


test_that("greedy_knapsack returns original row indices", {

  x <- data.frame(
    w = c(4, 1, 2),
    v = c(4, 5, 6)
  )

  result <- greedy_knapsack(x, W = 3)

  expect_equal(result$value, 11)
  expect_equal(result$elements, c(2L, 3L))
})


test_that("greedy_knapsack rejects input that is not a data.frame", {

  x <- matrix(c(1, 2, 3, 4), ncol = 2)

  expect_error(
    greedy_knapsack(x, W = 5),
    "x must be a data.frame"
  )
})


test_that("greedy_knapsack requires w and v columns", {

  x <- data.frame(
    weight = c(1, 2),
    value = c(5, 10)
  )

  expect_error(
    greedy_knapsack(x, W = 5),
    "x must contain columns named 'w' and 'v'"
  )
})


test_that("greedy_knapsack rejects non-positive weights or values", {

  x <- data.frame(
    w = c(1, -2),
    v = c(5, 10)
  )

  expect_error(
    greedy_knapsack(x, W = 5),
    "Weights and values must be positive"
  )
})


test_that("greedy_knapsack rejects invalid W", {

  x <- data.frame(
    w = c(1, 2),
    v = c(5, 10)
  )

  expect_error(
    greedy_knapsack(x, W = 0),
    "W must be a single positive numeric value"
  )

  expect_error(
    greedy_knapsack(x, W = "five"),
    "W must be a single positive numeric value"
  )
})
