#  taken from https://github.com/libgit2/libgit2/issues/4164
no_proxy <- paste(
  "192.168.1.1",
  "example.com",
  "foo.example3.com",
  "localhost",
  sep = ","
)

no_proxy_parsed <- c(
  "192.168.1.1",
  "example.com",
  "foo.example3.com",
  "localhost"
)

test_that("get_hostname() works", {

  # https
  expect_identical(
    get_hostname("https://acme.com/wilecoyote/plans"),
    "acme.com"
  )

  # http
  expect_identical(
    get_hostname("http://acme.com/wilecoyote/plans"),
    "acme.com"
  )

})

test_that("parse_items() works", {

  expect_identical(parse_items(""), character(0))
  expect_identical(parse_items(no_proxy), no_proxy_parsed)

})


test_that("regex_no_proxy() works", {

  regex_ref <- c(
    "192\\.168\\.1\\.1$",
    "example\\.com$",
    "foo\\.example3\\.com$",
    "localhost$"
  )

  expect_identical(regex_no_proxy(no_proxy_parsed), regex_ref)
  expect_identical(regex_no_proxy("*"), ".*$")

})
