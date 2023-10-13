test_that("getting current user data", {

  httptest2::with_mock_dir("http-tests/get_current_user", {

    current_user <- get_current_user()
  })

  expect_true(current_user$is_authorized)

  expect_true("email"                %in% names(current_user))
  expect_true("email_verified"       %in% names(current_user))
  expect_true("roles"                %in% names(current_user))
  expect_true("created_at"           %in% names(current_user))
  expect_true("time_now"             %in% names(current_user))
  expect_true("since_created_days"   %in% names(current_user))
  expect_true("freetrial_days_limit" %in% names(current_user))
  expect_true("is_freetrial_valid"   %in% names(current_user))

  httr2::local_mocked_responses(function(req) {
      httr2::response_json(
        status_code = 401,
        body = list())
  })

  current_user <- get_current_user()
  expect_false(current_user$is_authorized)

  httr2::local_mocked_responses(function(req) {
      httr2::response_json(
        status_code = 200,
        body = list())
  })

  current_user <- get_current_user()
  expect_true(current_user$is_authorized)
})
