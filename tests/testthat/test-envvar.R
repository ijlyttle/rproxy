test_that("list_proxy() works", {
  expect_identical(
    list_proxy("foo"),
    list(
      http_proxy = "foo",
      HTTP_PROXY = "foo",
      https_proxy = "foo",
      HTTPS_PROXY = "foo"
    )
  )
})

test_that("list_no_proxy() works", {
  expect_identical(
    list_no_proxy("foo"),
    list(
      no_proxy = "foo",
      NO_PROXY = "foo"
    )
  )
})

