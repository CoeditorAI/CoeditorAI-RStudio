test_that("proofread a text with default params", {

  test_text <- paste(
    "Writtting is dificult.",
    "This are tools that can helps you.",
    "For example those base on AI.")

  request <- proofread(text    = test_text,
                       dry_run = TRUE)

  expect_equal(request$body$data$text,
               test_text)
  expect_equal(request$body$data$temperature,
               1)
})

test_that("rewrite a text with different temperature", {

  test_text <- paste(
    "Writtting is dificult.",
    "This are tools that can helps you.",
    "For example those base on AI.")

  request <- rewrite(text        = test_text,
                     temperature = 0.5,
                     dry_run     = TRUE)

  expect_equal(request$body$data$temperature,
               0.5)
})
