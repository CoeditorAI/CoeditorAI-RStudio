test_that("initial Shiny values are consistent", {

  skip_on_cran()

  shiny_app <- coedit_text(debug = TRUE)

  app <- shinytest2:::AppDriver$new(name = "initial_values",
                                    app_dir = shiny_app,
                                    expect_values_screenshot_args = FALSE)

  app$expect_values(input = c("header_buttons-add_footer",
                              "header_buttons-done",
                              "header_buttons-restart",
                              "header_buttons-scroll_bottom",
                              "header_buttons-scroll_top",
                              "panels",
                              "quanda-q_and_a",
                              "settings-dark_mode",
                              "settings-temperature",
                              "settings-style",
                              "text_editor_1-copy",
                              "text_editor_1-drop",
                              "text_editor_1-paste",
                              "text_editor_1-proofread",
                              "text_editor_1-rewrite",
                              "text_editor_1-translate",
                              "text_editor_1-use_custom_prompt"),
                    output = TRUE,
                    export = TRUE)
})

test_that("rewrite is generated", {

  skip_on_cran()

  test_original_text <- "Test original text"

  shiny_app <- coedit_text(original_text = test_original_text,
                           debug = TRUE)

  test_input_variable <- "text_editor_1-rewrite"

  app <- shinytest2:::AppDriver$new(name = "rewrite",
                                    app_dir = shiny_app,
                                    expect_values_screenshot_args = FALSE)

  expect_equal(ignore_attr = TRUE,
               app$get_value(input = test_input_variable),
               0)

  expect_equal(app$get_value(export = "editors_counter"),
               1)

  expect_equal(app$get_value(export = "editors_outputs")[["text_editor_1"]],
               NULL)

  expect_equal(app$get_value(export = "last_output_text"),
               test_original_text)

  app$expect_values(input = c("text_editor_1-rewrite"),
                    output = TRUE,
                    export = TRUE)

  app$click(test_input_variable)

  expect_equal(app$get_value(export = "editors_counter"),
               2)

  test_output_text <- "Test output text from shiny.testmode."

  expect_equal(app$get_value(export = "editors_outputs")[["text_editor_1"]],
               test_output_text)

  expect_equal(app$get_value(export = "last_output_text"),
               test_output_text)

  app$expect_values(input = c("text_editor_1-rewrite"),
                    output = TRUE,
                    export = TRUE)
})
