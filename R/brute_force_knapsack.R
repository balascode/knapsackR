#' Solve the knapsack problem using brute force
#'
#' Finds the exact maximum value that can be placed in a knapsack
#' with capacity W by checking every possible subset of items.
#'
#' @param x A data.frame with columns `w` for weights and `v` for values.
#' @param W A positive numeric value giving the maximum knapsack capacity.
#'
#' @return A list with:
#' \describe{
#'   \item{value}{The maximum total value, rounded to the nearest integer.}
#'   \item{elements}{The row numbers of the selected items.}
#' }
#'
#'#' @examples
#' x <- data.frame(
#'   w = c(1, 3, 4),
#'   v = c(1, 4, 5)
#' )
#'
#' brute_force_knapsack(x, W = 5)
#'
#' @export
brute_force_knapsack <- function(x, W) {

  if (!is.data.frame(x)) {
    stop("x must be a data.frame.")
  }

  if (!all(c("w", "v") %in% names(x))) {
    stop("x must contain columns named 'w' and 'v'.")
  }

  if (any(x$w <= 0) || any(x$v <= 0)) {
    stop("Weights and values must be positive.")
  }

  if (!is.numeric(W) ||
      length(W) != 1 ||
      is.na(W) ||
      !is.finite(W) ||
      W <= 0) {
    stop("W must be a single positive numeric value.")
  }

  n <- nrow(x)

  if (n == 0) {
    return(
      list(
        value = 0,
        elements = integer()
      )
    )
  }

  weights <- x$w
  values <- x$v

  masks <- bitwShiftL(
    1L,
    0:(n - 1)
  )

  best_value <- 0
  best_elements <- integer()

  for (subset_id in 0:(2^n - 1)) {

    selected <-
      bitwAnd(
        as.integer(subset_id),
        masks
      ) != 0L

    total_weight <-
      sum(weights[selected])

    if (total_weight <= W) {

      total_value <-
        sum(values[selected])

      if (total_value > best_value) {

        best_value <- total_value
        best_elements <- which(selected)
      }
    }
  }

  list(
    value = round(best_value),
    elements = best_elements
  )
}
