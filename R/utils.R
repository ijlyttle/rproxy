# inspired by rlang::`%||%`, but for empty strings
`%|.|%` <- function(x, y) {
  if (identical(x, "")) {
    y
  } else {
    x
  }
}
