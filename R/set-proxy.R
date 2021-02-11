#' Set proxy environment-variables temporarily
#'
#' @description
#' Given a `url` and the your current proxy and no-proxy environment-variables,
#' these functions *temporarily* set your proxy environment-variables:
#' \describe{
#'   \item{`local_proxy_for_url()`}{Set until the current evaluation context
#'     ends (such as the end of a function).}
#'   \item{`with_proxy_for_url()`}{Set only for the execution of the
#'     enclosed `code`.}
#'   \item{`without_proxy()`}{For the execution of the enclosed `code`,
#'     regardless of `url`, unsets the proxy environment-variables.}
#' }
#'
#' These functions `local_proxy_for_url()` and `with_proxy_for_url()` are useful
#' in situations where the proxy variables are effective, and the no-proxy
#' variable is not effective.
#'
#' The function `without_proxy()` particularly useful for when you need to call
#' *another* function interactively, but need to turn the proxy off.
#'
#' @details
#' These functions themselves call [withr::withr] `with_` and `local_` functions;
#' they behave in the same way as the withr functions.
#'
#' @inheritParams uses_proxy
#' @param .local_envir `environment`, the environment to use for scoping.
#' @param code The code to execute in the temporary environment.
#'
#' @return These functions are called for their side-effects:
#' \describe{
#'   \item{`local_proxy_for_url()`}{`character` vector of previous values of
#'     proxy environment-variables, invisibly.}
#'   \item{`with_proxy_for_url()`}{The results of the evaluation of the `code`
#'     argument.}
#'   \item{`without_proxy()`}{The results of the evaluation of the `code`
#'     argument.}
#' }
#' @examples
#' # sets your proxy variables to the right value for a given `url`
#' local_proxy_for_url("https://github.acme.com")
#' envvar_proxy()
#' withr::deferred_clear() # reset state
#'
#' # same as above, but for enclosed code
#' with_proxy_for_url(
#'   "https://github.acme.com",
#'   envvar_proxy()
#' )
#'
#' # run with proxy off
#' without_proxy(
#'   envvar_proxy()
#' )
#' @export
#'
local_proxy_for_url <- function(url, .local_envir = parent.frame()) {

  withr::local_envvar(
    .new = list_proxy(get_proxy(url)),
    .local_envir = .local_envir
  )

}

#' @rdname local_proxy_for_url
#' @export
#'
with_proxy_for_url <- function(url, code) {

  # uses proxy and no_proxy from environment variables
  withr::with_envvar(
    new = list_proxy(get_proxy(url)),
    code
  )

}

#' @rdname local_proxy_for_url
#' @export
#'
without_proxy <- function(code) {

  withr::with_envvar(
    new = list_proxy(NA_character_),
    code = code
  )

}
