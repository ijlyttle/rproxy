# inspired by rlang::`%||%`, but for empty strings
`%|.|%` <- function(x, y) {
  if (identical(x, "")) {
    y
  } else {
    x
  }
}

# return character hostname from url
get_hostname <- function(url) {
  sub("^http[s]?://([^/:]+).*$", "\\1", url)
}

# return character or NULL, split string by comma
parse_items <- function(x) {

  vals <- strsplit(x, ",")[[1]]

  vals
}

# return character regexes from no_proxy specs (parsed)
regex_no_proxy <- function(no_proxy_parsed) {

  # this function is vectorized

  regex <- no_proxy_parsed

  # escape the existing dots: prepend all . with \\
  regex <- gsub("\\.", "\\\\.", regex)

  # where we see a wildcard (*), replace with (.*)
  regex <- gsub("\\*", ".*", regex)

  # append with $
  regex <- paste0(regex, "$")

  regex
}

