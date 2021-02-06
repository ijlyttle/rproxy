envvar_proxy <- function() {

  proxy <-
    Sys.getenv("http_proxy") %||%
    Sys.getenv("HTTP_PROXY") %||%
    Sys.getenv("https_proxy") %||%
    Sys.getenv("HTTPS_PROXY")

  proxy
}

envvar_no_proxy <- function() {

  # https://curl.se/libcurl/c/CURLOPT_NOPROXY.html
  no_proxy <-
    Sys.getenv("no_proxy") %||%
    Sys.getenv("NO_PROXY")

}

list_proxy <- function(value) {
  list(
    http_proxy = value,
    HTTP_PROXY = value,
    https_proxy = value,
    HTTPS_PROXY = value
  )
}

list_no_proxy <- function(value) {
  list(
    no_proxy = value,
    NO_PROXY = value
  )
}
