
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rproxy

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/rproxy)](https://CRAN.R-project.org/package=rproxy)

<!-- badges: end -->

The goal of rproxy is to help you set proxy variables in situations that
do not follow the [cURL](https://curl.se/) convention. Personal note: I
was sorely tempted to name this package proxymusic.

If you use a proxy, you are likely familiar with setting this
combination of environment variables:

    http_proxy=http://proxy.acme.com
    https_proxy=http://proxy.acme.com
    HTTP_PROXY=http://proxy.acme.com
    HTTPS_PROXY=http://proxy.acme.com
    no_proxy=127.0.0.1,localhost,github.acme.com

## Installation

You can install development version from [GitHub](https://github.com/)
with:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/rproxy")
```

## Example

Nothing yet.