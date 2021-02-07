test_that("envvar_proxy() works", {
  withr::local_envvar(list_proxy("foo"))
  expect_identical(envvar_proxy(), "foo")
})

test_that("envvar_no_proxy() works", {
  withr::local_envvar(list_no_proxy("foo"))
  expect_identical(envvar_no_proxy(), "foo")
})


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

