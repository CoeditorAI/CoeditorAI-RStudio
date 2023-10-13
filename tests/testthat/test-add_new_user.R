test_that("adding a new user", {

  request <- add_new_user(email = "test_email",
                          terms_accepted = TRUE,
                          dry_run = TRUE)

  expect_equal(request$body$data$email,
               "test_email")
  expect_equal(request$body$data$terms_accepted,
               TRUE)
})
