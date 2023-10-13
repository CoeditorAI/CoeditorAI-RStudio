test_that("getting default API URL", {

  withr::local_envvar(list(
    COEDITORAI_API_URL = ""
  ))

  expect_equal(
    get_api_url(),
    "https://coeditorai.com/api/v1"
  )
})

test_that("soft failure on checking if API is alive", {

  withr::local_envvar(list(
    COEDITORAI_API_URL = "http://bad-url"
  ))

  expect_false(is_api_alive())
})

test_that("success on checking if API is alive", {

  httptest2::with_mock_dir("http-tests/is_api_alive", {

    expect_true(is_api_alive())
  })

  httr2::local_mocked_responses(function(req) {
    httr2::response_json(
      status_code = 200,
      body = list(
        is_alive = TRUE
      ))
  })

  expect_true(is_api_alive())
})


test_that("creating basic API request", {

  request <- create_api_request()

  expect_equal(request$url,
               get_api_url())

  expect_true(is.character(request$headers$Authorization))
  expect_true(is.character(request$options$useragent))
  expect_true(is.numeric(request$options$timeout_ms))
  expect_null(request$body)
})

test_that("creating GET API request", {

  request <- create_get_api_request()
  expect_snapshot(request, transform = transform_snapshot)
})

test_that("creating POST API request", {

  request <- create_post_api_request()
  expect_snapshot(request, transform = transform_snapshot)

  expect_true("coeditorai"    %in% names(request$body$data))
  expect_true("session_id"    %in% names(request$body$data$coeditorai))
  expect_true("input_text_id" %in% names(request$body$data$coeditorai))
})

test_that("getting versions", {

  skip_on_cran()

  versions <- get_versions()

  expect_true(is.character(versions$api_version))
  expect_true(
    is.na(versions$r_package$github_main) ||
    is.character(versions$r_package$github_main))
  expect_true(
    is.na(versions$r_package$github_devel) ||
    is.character(versions$r_package$github_devel))
  expect_true(
    is.na(versions$r_package$cran) ||
    is.character(versions$r_package$cran))
})
