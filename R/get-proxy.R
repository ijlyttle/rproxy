#' Determine proxy
#'
#' Use these functions to determine if a `proxy` should be used for a given
#' `url` and `no_proxy` string.
#'
#' This aims to emulate the
#' [cURL specification](https://curl.se/libcurl/c/CURLOPT_NOPROXY.html)
#' for `NO_PROXY`. The biggest difference between this implementation and the
#' cURL specification is that the wildcard character (`*`) is used more
#' permissibly here.
#'
#' Note that `get_proxy()` returns `NA` if the proxy should not be used;
#' this is the value used to **set** the proxy environment-variables. This is
#' different from [envvar_proxy()], which will return `""` for an unset
#' environment-variable. This reflects the difference in syntax between
#' between [withr::with_envvar()] and [Sys.getenv()].
#'
#' @param url `character` address for which to determine the proxy.
#' @param proxy `character` the proxy that would be used.
#' @param no_proxy `character` comma-separated string containing hostnames
#'   where the proxy is not to be used.
#'
#' @return \describe{
#'   \item{`uses_proxy()`}{`logical` indicating if the proxy should be used.}
#'   \item{`get_proxy()`}{`character` value of proxy to use, `NA` if no proxy.}
#' }
#' @examples
#'   proxy <- "http://proxy.acme.com"
#'   no_proxy <- "github.acme.com,localhost,127.0.0.1"
#'
#'   uses_proxy("https://github.com", no_proxy)      # TRUE
#'   uses_proxy("https://github.acme.com", no_proxy) # FALSE
#'
#'   get_proxy("https://github.com", proxy, no_proxy) # "http://proxy.acme.com"
#'   get_proxy("https://github.acme.com", proxy, no_proxy) # ""
#' @export
#'
uses_proxy <- function(url, no_proxy = envvar_no_proxy()) {

  # assert that url and no_proxy are both character, length 1
  stopifnot(
    "`url` must be character and scalar" =
      is.character(url) && identical(length(url), 1L),
    "`no_proxy` must be character and scalar1" =
      is.character(no_proxy) && identical(length(no_proxy), 1L)
  )

  no_proxy_parsed <- parse_items(no_proxy)

  # if there are no no_proxy items, return TRUE (use the proxy)
  if (identical(length(no_proxy_parsed), 0L)) return(TRUE)

  hostname <- get_hostname(url)
  regex <- regex_no_proxy(no_proxy_parsed)

  # apply all the regexes to the url to see if we have a match
  match_no_proxy <- vapply(regex, grepl, logical(1), url)

  # use the proxy if there are no matches to no-proxy
  use_proxy <- all(!match_no_proxy)

  use_proxy
}

#' @rdname uses_proxy
#' @export
#'
get_proxy <- function(url, proxy = envvar_proxy(),
                      no_proxy = envvar_no_proxy()) {

  # assert that proxy is character, length 1
  stopifnot(
    "`proxy` must be character and scalar" =
      is.character(proxy) && identical(length(proxy), 1L),
    "`proxy` must be character and scalar" =
      is.character(proxy) && identical(length(proxy), 1L)
  )

  if (!uses_proxy(url = url, no_proxy = no_proxy)) {
    proxy <- NA_character_
  }

  proxy
}

