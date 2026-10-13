#' Solve the knapsack problem using a greedy heuristic
#'
#' Finds an approximate solution to the knapsack problem by
#' selecting items based on their value-to-weight ratio.
#'
#' @param x A data.frame with columns `w` for weights and `v` for values.
#' @param W A positive numeric value giving the maximum knapsack capacity.
#'
#' @return A list with:
#' \describe{
#'   \item{value}{The total value of the selected items.}
#'   \item{elements}{The row numbers of the selected items.}
#' }
#'
#' @export
greedy_knapsack <- function(x, W) {

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

  # Sort items by their value-to-weight ratio
  ratio <- x$v / x$w
  order_items <- order(ratio, decreasing = TRUE)

  total_weight <- 0
  total_value <- 0
  elements <- integer()

  # Add items as long as they fit
  for (i in order_items) {

    if (total_weight + x$w[i] <= W) {

      total_weight <- total_weight + x$w[i]
      total_value <- total_value + x$v[i]

      elements <- c(elements, i)
    }
  }

  list(
    value = total_value,
    elements = elements
  )
}
