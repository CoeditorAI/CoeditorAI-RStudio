library(shiny)

test_that("testing text_coeditor module", {

  withr::local_options("coeditorai.verbose" = FALSE)

  test_input_text  <- "Test input text"
  test_output_text <- "Test output text"

  httr2::local_mocked_responses(function(req) {
    httr2::response_json(
      status_code = 200,
      body = list(text = test_output_text))
  })

  shiny::testServer(app = mod_text_coeditor_server, args = list(
    input_text  = test_input_text,
    session_id  = function() "Test session",
    temperature = function() 1,
    style       = function() "default"
    ), {

      expect_true(
        stringr::str_detect(output$input_text[[1]],
                            test_input_text))

      session$setInputs(rewrite = 1)

      expect_equal(output_text(),
                   test_output_text)
  })
})
