test_that("sending event", {

  withr::local_options("coeditorai.verbose" = FALSE)

  request <- send_text_event(text       = "Some test text",
                             event_name = "Test event",
                             dry_run    = TRUE)


  expect_true(is.character(request$body$data$coeditorai$input_text_id))
  expect_equal(request$body$data$event_name,
               "Test event")
  expect_equal(request$body$data$event_type,
               "INFO")
})
