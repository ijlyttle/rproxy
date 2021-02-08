
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rproxy

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rproxy)](https://CRAN.R-project.org/package=rproxy)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/ijlyttle/rproxy/workflows/R-CMD-check/badge.svg)](https://github.com/ijlyttle/rproxy/actions)

<!-- badges: end -->

The goal of rproxy is to help you set proxy variables in situations that
do not follow the [cURL](https://curl.se/) convention. Personal note: I
was sorely tempted to name this package proxymusic.

If you use a proxy, you are likely familiar with setting this
combination of environment variables used by cURL:

    http_proxy=http://proxy.acme.com
    https_proxy=http://proxy.acme.com
    HTTP_PROXY=http://proxy.acme.com
    HTTPS_PROXY=http://proxy.acme.com
    no_proxy=127.0.0.1,localhost,github.acme.com

You will note the repetition of values proxy environment variables. I
have never seen them differ within the pattern, but I have worked for
only one company.

When it makes an http(s) connection, a system library will often use
this combination of variables to decide it it needs to use the proxy. If
your system library uses cURL, things will *just work*. If they don’t,
then you may need to get creative. This is where this package may help.

## Installation

You can install development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/rproxy")
```

## Example

There are three sets of functions in this package.

You can determine your current proxy and no-proxy environment-variables:

``` r
library("rproxy")
envvar_proxy()
#> [1] "http://proxy.acme.com"
```

``` r
envvar_no_proxy()
#> [1] "127.0.0.1,localhost,github.acme.com"
```

You can determine if you need to use the proxy for a given `url`. These
functions can be useful if your system library does not use the cURL
convention and you need to provide a value for the proxy.

``` r
uses_proxy("https://github.com/")
#> [1] TRUE
```

``` r
get_proxy("https://github.com/")
#> [1] "http://proxy.acme.com"
```

You can also set the value of the proxy environment-variables
temporarily. This may be useful for situations where the system library
recognizes the proxy environment-variable, but no the no-proxy
environment variable.

You can insist that the proxy not be used - this could be useful for
interactive work:

``` r
without_proxy(
  envvar_proxy() 
)
#> [1] ""
```

You can also *temporarily* set the proxy environment-variable for a
`url` by applying the no-proxy environment-variable using R rather than
the system library. These functions use the amazing
[withr](https://withr.r-lib.org/) package.

You can use `with_proxy_for_url()` to set the proxy environment-variable
only for the scope of the call; outside the call, nothing has changed:

``` r
with_proxy_for_url(
  "localhost",
  envvar_proxy() 
)
#> [1] ""
```

``` r
envvar_proxy() 
#> [1] "http://proxy.acme.com"
```

To set the proxy environment-variable within the scope of a function you
provide, `local_proxy_for_url()` can be useful:

``` r
new_envvar_proxy <- function(url) {
  rproxy::local_proxy_for_url("localhost")
  rproxy::envvar_proxy()
}

new_envvar_proxy()
#> [1] ""
```

``` r
envvar_proxy() 
#> [1] "http://proxy.acme.com"
```

## Code of Conduct

Please note that the rproxy project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
