test_that("testing if selected text is valid", {

  expect_true(is_selected_text_valid("asdf"))

  expect_message(expect_message(
    expect_false(is_selected_text_valid(""))
  ))
})

test_that("testing if credentials are set", {

  withr::local_envvar(list(
    COEDITORAI_USER_EMAIL    = "",
    COEDITORAI_USER_PASSWORD = ""
  ))
  expect_message(expect_message(expect_message(
    check_user_credentials()
  )))

  withr::local_envvar(list(
    COEDITORAI_USER_EMAIL    = "asdf",
    COEDITORAI_USER_PASSWORD = ""
  ))
  expect_message(expect_message(
    check_user_credentials()
  ))

  withr::local_envvar(list(
    COEDITORAI_USER_EMAIL    = "",
    COEDITORAI_USER_PASSWORD = "asdf"
  ))
  expect_message(expect_message(
    check_user_credentials()
  ))

  withr::local_envvar(list(
    COEDITORAI_USER_EMAIL    = "asdf",
    COEDITORAI_USER_PASSWORD = "asdf"
  ))
  expect_silent(
    check_user_credentials()
  )
})
