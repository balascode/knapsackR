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
#' @examples
#' x <- data.frame(
#'   w = c(1, 3, 4),
#'   v = c(1, 4, 5)
#' )
#'
#' knapsack_dynamic(x, W = 5)
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

    previous_row <- dp[i, ]
    current_row <- previous_row

    if (item_weight <= W) {

      capacities <- item_weight:W

      without_item <-
        previous_row[capacities + 1]

      with_item <-
        item_value +
        previous_row[capacities - item_weight + 1]

      current_row[capacities + 1] <-
        pmax(without_item, with_item)
    }

    dp[i + 1, ] <- current_row
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
