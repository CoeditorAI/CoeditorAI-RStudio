test_that("translate a text", {

  test_text <- paste(
    "Pisanie może być trudne, ale istnieją narzędzia, które mogą pomóc.",
    "Jednym z przykładów są specjalne narzędzia",
    "oparte na sztucznej inteligencji (AI).")

  request <-
    translate(text            = test_text,
              target_language = "English",
              dry_run = TRUE)

  expect_equal(request$body$data$text,
               test_text)
  expect_equal(request$body$data$temperature,
               1)
  expect_equal(request$body$data$target_language,
               "English")
})

test_that("translate text with different temperature", {

  test_text <- paste(
    "Pisanie może być trudne, ale istnieją narzędzia, które mogą pomóc.",
    "Jednym z przykładów są specjalne narzędzia",
    "oparte na sztucznej inteligencji (AI).")

  request <-
    translate(text            = test_text,
              target_language = "Polish",
              temperature     = 0.5,
              dry_run = TRUE)

  expect_equal(request$body$data$temperature,
               0.5)
  expect_equal(request$body$data$target_language,
               "Polish")
})
