#  taken from https://github.com/libgit2/libgit2/issues/4164
no_proxy_ref <- paste(
  "192.168.1.1",
  "example.com",
  "*.example1.com",
  ".example2.com",
  "foo.example3.com",
  "foo.*.example4.com",
  "localhost",
  sep = ","
)

proxy_ref <- "http://proxy.acme.com"

test_that("use_proxy() works", {

  # non-character arguments
  expect_error(
    use_proxy(url = 1, no_proxy = "baz"),
    "`url` must be character and scalar"
  )
  expect_error(
    use_proxy(url = "foo", no_proxy = 1),
    "`no_proxy` must be character and scalar"
  )

  # non-scalar arguments
  expect_error(
    use_proxy(url = c("foo", "bar"), no_proxy = "baz"),
    "`url` must be character and scalar"
  )
  expect_error(
    use_proxy(url = "foo", no_proxy = c("bar", "baz")),
    "`no_proxy` must be character and scalar"
  )

  expect_use_proxy <- function(url, result, no_proxy = no_proxy_ref) {
    use_proxy <- use_proxy(url, no_proxy = no_proxy)
    expect_identical(use_proxy, result)
  }

  expect_use_proxy("cnn.com", TRUE)
  expect_use_proxy("192.168.1.1", FALSE)
  expect_use_proxy("example.com", FALSE)
  expect_use_proxy("bar.example.com", TRUE)
  expect_use_proxy("bar.example1.com", FALSE)
  expect_use_proxy("foo.example3.com", FALSE)
  expect_use_proxy("foo.bar.example4.com", FALSE)
  expect_use_proxy("localhost", FALSE)

})

test_that("get_proxy() works", {

  # non-character arguments
  expect_error(
    get_proxy(url = "foo", proxy = 1, no_proxy = ""),
    "`proxy` must be character and scalar"
  )

  # non-scalar arguments
  expect_error(
    get_proxy(url = "foo", proxy = c("bar", "baz"), no_proxy = ""),
    "`proxy` must be character and scalar"
  )


  expect_get_proxy <- function(url, result, proxy = proxy_ref,
                               no_proxy = no_proxy_ref) {
    proxy <- get_proxy(url, proxy = proxy, no_proxy = no_proxy)
    expect_identical(proxy, result)
  }

  expect_get_proxy("cnn.com", proxy_ref)
  expect_get_proxy("192.168.1.1", "")

})
