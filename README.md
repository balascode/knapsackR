# knapsackR
[![R-CMD-check](https://github.com/balascode/knapsackR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/balascode/knapsackR/actions/workflows/R-CMD-check.yaml)

This is an R package implementing three algorithms for solving the 0/1 Knapsack Problem.

The package was developed as part of the Advanced Programming in R course at Linköping University.

The 0/1 Knapsack Problem involves selecting items with different weights and values to maximise the total value without exceeding a specified weight capacity.

The package implements three algorithms:

  - `brute_force_knapsack()` - Finds an optimal solution by evaluating possible combinations of items.
- `knapsack_dynamic()` - Finds an optimal solution using dynamic programming.
- `greedy_knapsack()` - Finds an approximate solution using a greedy heuristic based on the value-to-weight ratio.

## Requirements

The package uses the following R packages for development and testing:

  - `devtools`
- `testthat`
- `roxygen2`
- `remotes`

## Installation

Install the required development packages:

  ```r
install.packages(c(
  "devtools",
  "testthat",
  "roxygen2",
  "remotes"
))
```

Install `knapsackR` from GitHub:

  ```r
remotes::install_github("balascode/knapsackR")
```

Load the package:

  ```r
library(knapsackR)
```

## Generate test data

The following code generates reproducible test data using the method provided in the laboratory instructions.

```r
RNGversion(min(as.character(getRversion()), "3.5.3"))

set.seed(
  42,
  kind = "Mersenne-Twister",
  normal.kind = "Inversion"
)

n <- 2000

knapsack_objects <- data.frame(
  w = sample(1:4000, size = n, replace = TRUE),
  v = runif(n = n, 0, 10000)
)
```

The dataset contains two columns:

  - `w` - Weight of each item.
- `v` - Value of each item.

The parameter `W` represents the maximum knapsack capacity.

## Implemented algorithms

### 1. Brute Force

The brute force algorithm examines possible combinations of items to determine the optimal solution.

Example:

  ```r
brute_force_knapsack(
  x = knapsack_objects[1:8, ],
  W = 3500
)
```

Brute force guarantees an optimal solution but becomes computationally expensive as the number of items increases.

### 2. Dynamic Programming

The dynamic programming algorithm solves the problem by storing and reusing results from smaller subproblems.

Example:

  ```r
knapsack_dynamic(
  x = knapsack_objects[1:100, ],
  W = 3500
)
```

Dynamic programming finds an optimal solution while avoiding repeated calculations.

### 3. Greedy Heuristic

The greedy heuristic sorts items by decreasing value-to-weight ratio, adds items in that order, and stops when the next item does not fit within the remaining capacity.

Example:

  ```r
greedy_knapsack(
  x = knapsack_objects[1:800, ],
  W = 3500
)
```

The greedy heuristic is faster for large datasets but does not guarantee an optimal solution.

## Algorithm comparison

| Algorithm | Time complexity | Optimal solution |
  |---|---|---|
  | Brute Force | O(2^n) | Yes |
  | Dynamic Programming | O(nW) | Yes |
  | Greedy Heuristic | O(n log n) | Not guaranteed |

  Here, `n` represents the number of items and `W` represents the knapsack capacity.

## Output

All three functions return a list containing:

  - `value` - Total value of the selected items.
- `elements` - Row indices of the selected items.

Example:

  ```r
x <- data.frame(
  w = c(1, 3, 4),
  v = c(1, 4, 5)
)

knapsack_dynamic(x, W = 5)
```

Expected output:

  ```text
$value
[1] 6

$elements
[1] 1 3
```

## Performance testing

The laboratory report vignette benchmarks the greedy heuristic using
1,000,000 reproducibly generated objects and compares the original and current
implementations using the same course-specified greedy rule.

Execution times are intentionally not hard-coded in this README because they
depend on the computer and current system load. The vignette reports the
measurements produced when it is built.

To reproduce the required one-million-object timing experiment:

```r
suppressWarnings(
  RNGversion(min(as.character(getRversion()), "3.5.3"))
)

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

system.time(
  greedy_knapsack(
    x = knapsack_objects,
    W = 3500
  )
)
```

## Testing

The package uses `testthat` for automated testing.

The package includes the official course test suites for `brute_force_knapsack()` and `greedy_knapsack()`, together with a student-written test suite for `knapsack_dynamic()`. The tests cover correctness, return values, selected elements, and input validation.

To run all unit tests:

  ```r
devtools::test()
```

To generate package documentation:

  ```r
devtools::document()
```

To check the complete package:

  ```r
devtools::check()
```

## Documentation

Documentation for each algorithm is available through R's help system:

```r
?brute_force_knapsack
?knapsack_dynamic
?greedy_knapsack
```

The laboratory report vignette provides further information about the algorithms, performance measurements, and optimisation.

## Package repository

The R package is available on GitHub:

https://github.com/balascode/knapsackR

## Authors

**Venkata Balaji Anupoju**
LiU ID: `venan324`
GitHub: `balascode`

**Marwan Karim**
LiU ID: `marka671`
GitHub: `Hakaishinnn`

Developed for:

**732A94 - Advanced Programming in R**
Linköping University
