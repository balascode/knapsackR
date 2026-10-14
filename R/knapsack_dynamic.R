#' Solve the knapsack problem using dynamic programming
#'
#' Finds the maximum total value that can be placed in a knapsack
#' with capacity W using a dynamic programming approach.
#'
#' @param x A data.frame with columns `w` for weights and `v` for values.
#' @param W A positive numeric value giving the maximum knapsack capacity.
#'
#' @return A list with:
#' \describe{
#'   \item{value}{The maximum total value.}
#'   \item{elements}{The row numbers of the selected items.}
#' }
#'
#' @export
knapsack_dynamic <- function(x, W) {

  if (!is.data.frame(x)) {
    stop("x must be a data.frame.")
  }

  if (!all(c("w", "v") %in% names(x))) {
    stop("x must contain columns named 'w' and 'v'.")
  }

  if (any(x$w <= 0) || any(x$v <= 0)) {
    stop("Weights and values must be positive.")
  }

  if (!is.numeric(W) || length(W) != 1 || is.na(W) || W <= 0) {
    stop("W must be a single positive numeric value.")
  }

  W <- floor(W)

  n <- nrow(x)

  dp <- matrix(
    0,
    nrow = n + 1,
    ncol = W + 1
  )

  for (i in seq_len(n)) {

    item_weight <- x$w[i]
    item_value <- x$v[i]

    for (capacity in 0:W) {

      if (item_weight > capacity) {
        dp[i + 1, capacity + 1] <- dp[i, capacity + 1]
      }
      else {
        without_item <- dp[i, capacity + 1]
        with_item <- item_value + dp[i, capacity - item_weight + 1]
        dp[i + 1, capacity + 1] <- max(without_item, with_item)
      }
    }
  }

  elements <- integer()

  capacity <- W

  for (i in n:1) {

    current_value <- dp[i + 1, capacity + 1]
    previous_value <- dp[i, capacity + 1]

    if (current_value != previous_value) {
      elements <- c(i, elements)
      capacity <- capacity - x$w[i]
    }
  }

  list(
    value = round(dp[n + 1, W + 1]),
    elements = elements
  )
}
