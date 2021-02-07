#' Get environment-variables for proxy
#'
#'  \describe{
#'    \item{`envvar_proxy()`}{returns first value found in the sequence of
#'     environment variables:
#'     `"http_proxy"`, `"HTTP_PROXY"`, `"https_proxy"`, `"HTTPS_PROXY"`.
#'    }
#'    \item{`envvar_no_proxy()`}{returns first value found in the sequence of
#'     environment variables: `"no_proxy"`, `"NO_PROXY"`.}
#'  }
#'
#' @return `character` value of proxy or no_proxy environment-variable.
#' @examples
#'   envvar_proxy()
#'   envvar_no_proxy()
#' @export
#'
envvar_proxy <- function() {

  # https://curl.se/libcurl/c/CURLOPT_PROXY.html
  proxy <-
    Sys.getenv("http_proxy") %|.|%
    Sys.getenv("HTTP_PROXY") %|.|%
    Sys.getenv("https_proxy") %|.|%
    Sys.getenv("HTTPS_PROXY")

  proxy
}

#' @rdname envvar_proxy
#' @export
#'
envvar_no_proxy <- function() {

  # https://curl.se/libcurl/c/CURLOPT_NOPROXY.html
  no_proxy <-
    Sys.getenv("no_proxy") %|.|%
    Sys.getenv("NO_PROXY")

  no_proxy
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
