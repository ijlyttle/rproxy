proxy <- "http://proxy.acme.com"
no_proxy <- "github.acme.com"

expect_proxy_unset <- function() {
  expect_false(any(names(list_proxy("")) %in% names(Sys.getenv())))
}

# set proxy and no-proxy variables within test scope
withr::local_envvar(
  c(list_proxy(proxy), list_no_proxy(no_proxy))
)

test_that("without_proxy() works", {

  # confirm they are set
  expect_identical(envvar_proxy(), proxy)

  without_proxy(
    # confirm they are *not* set
    expect_proxy_unset()
  )

  # confirm they are still set
  expect_identical(envvar_proxy(), proxy)

})

test_that("with_proxy_for_url() works", {

  # confirm they are set
  expect_identical(envvar_proxy(), proxy)

  # confirm they are *not* set (using url in no_proxy)
  with_proxy_for_url(
    url = "https://github.acme.com",
    expect_proxy_unset()
  )

  # confirm they are set (using url *not* in no_proxy)
  with_proxy_for_url(
    "https://cnn.com",
    expect_identical(envvar_proxy(), proxy)
  )

  # confirm they are still set
  expect_identical(envvar_proxy(), proxy)

})

test_that("local_proxy_for_url() works", {

  # confirm they are set
  expect_identical(envvar_proxy(), proxy)

  # "turn off" proxy within function scope
  expect_local <- function() {
    local_proxy_for_url("https://github.acme.com")
    expect_proxy_unset()
  }

  # actually test
  expect_local()

  # confirm they are still set
  expect_identical(envvar_proxy(), proxy)

})

