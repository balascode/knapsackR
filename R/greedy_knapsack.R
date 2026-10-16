
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
#'#' @examples
#' x <- data.frame(
#'   w = c(1, 3, 4),
#'   v = c(1, 4, 5)
#' )
#'
#' greedy_knapsack(x, W = 5)
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

  # Extract columns once to reduce repeated access
  weights <- x$w
  values <- x$v

  # Sort items by their value-to-weight ratio
  ratio <- values / weights
  order_items <- order(ratio, decreasing = TRUE)

  total_weight <- 0
  total_value <- 0

  # Preallocate memory for selected items
  elements <- integer(nrow(x))
  count <- 0L

  # Add items as long as they fit
  for (i in order_items) {

    item_weight <- weights[i]

    if (total_weight + item_weight <= W) {

      total_weight <- total_weight + item_weight
      total_value <- total_value + values[i]

      count <- count + 1L
      elements[count] <- i
    }
  }

  # Keep only the selected items
  elements <- elements[seq_len(count)]

  list(
    value = total_value,
    elements = elements
  )
}
