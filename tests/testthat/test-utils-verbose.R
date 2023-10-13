test_that("verbose is on by default", {

  withr::local_options("coeditorai.verbose" = NULL)

  expect_true(is_verbose())
})

test_that("verbose is off with option FALSE", {

  withr::local_options("coeditorai.verbose" = FALSE)

  expect_false(is_verbose())
})

test_that("verbose is onn with option TRUE", {

  withr::local_options("coeditorai.verbose" = TRUE)

  expect_true(is_verbose())
})
