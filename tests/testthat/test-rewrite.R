test_that("rewrite a text with default params", {

  test_text <- paste(
    "Writing is difficult.",
    "There are tools that can help you.",
    "For example, those based on AI.")

  request <- rewrite(text    = test_text,
                     dry_run = TRUE)

  expect_equal(request$body$data$text,
               test_text)
  expect_equal(request$body$data$style,
               "default")
  expect_equal(request$body$data$temperature,
               1)
})

test_that("rewrite a text with different temperature", {

  test_text <- paste(
    "Writing is difficult.",
    "There are tools that can help you.",
    "For example, those based on AI.")

  request <- rewrite(text        = test_text,
                     temperature = 0.5,
                     dry_run     = TRUE)

  expect_equal(request$body$data$temperature,
               0.5)
})

test_that("rewrite a text in different styles", {

  test_text <- paste(
    "Writing is difficult.",
    "There are tools that can help you.",
    "For example, those based on AI.")

  request <- rewrite(text    = test_text,
                     style   = "informal",
                     dry_run = TRUE)

  expect_equal(request$body$data$style,
               "informal")

  request <- rewrite(text    = test_text,
                     style   = "formal",
                     dry_run = TRUE)

  expect_equal(request$body$data$style,
               "formal")
})

