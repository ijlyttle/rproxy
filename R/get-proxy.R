
use_proxy <- function(url, no_proxy = envvar_no_proxy()) {

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



get_proxy <- function(url, proxy = envvar_proxy(),
                      no_proxy = envvar_no_proxy()) {

  # assert that proxy is character, length 1
  stopifnot(
    "`proxy` must be character and scalar" =
      is.character(proxy) && identical(length(proxy), 1L),
    "`proxy` must be character and scalar" =
      is.character(proxy) && identical(length(proxy), 1L)
  )

  if (!use_proxy(url = url, no_proxy = no_proxy)) {
    proxy <- ""
  }

  proxy
}

