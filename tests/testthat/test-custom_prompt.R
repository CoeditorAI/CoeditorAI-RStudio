test_that("use custom prompt", {

  test_text <- paste(
    "Pisanie może być trudne, ale istnieją narzędzia, które mogą pomóc.",
    "Jednym z przykładów są specjalne narzędzia",
    "oparte na sztucznej inteligencji (AI).")

  test_custom_prompt <- "Return only first word."

  request <-
    custom_prompt(text          = test_text,
                  custom_prompt = test_custom_prompt,
                  temperature   = 0.5,
                  dry_run = TRUE)

  expect_equal(request$body$data$text,
               test_text)
  expect_equal(request$body$data$temperature,
               0.5)
  expect_equal(request$body$data$custom_prompt,
               test_custom_prompt)
})
