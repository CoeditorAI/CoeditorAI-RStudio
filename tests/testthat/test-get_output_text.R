test_that("getting output text", {

  withr::local_options("coeditorai.verbose" = FALSE)

  func <- function(...) {list(text = "Test output")}

  expect_equal(get_output_text(func = func),
               "Test output")
})
