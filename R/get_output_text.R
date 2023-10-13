
get_output_text <- function(func,
                            verbose = is_verbose(),
                            ...) {

  output_text <-
    tryCatch({

      if (isTRUE(getOption("shiny.testmode"))) {
        output <- list(text = "Test output text from shiny.testmode.")
      } else {
        output <- func(...)
      }

      if (verbose) cli::cli_alert_success(cli::col_green("Done."))

      if (shiny::isRunning()) {
        shiny::showNotification(
          type     = "default",
          duration = 3,
          ui       = "Done!",
          action   = NULL)
      }
      output$text
    },
    error = function(e) {

      cli::cli_alert_danger(cli::col_red(
        "Error while communicating with the CoeditorAI API:"))
      cli::cli_alert_danger(cli::col_red(e$message))

      if (!is.null(e$resp)) {
        cli::cli_alert_info(
          httr2::resp_body_json(e$resp) |> unlist()
        )
      }

      if (!is.null(e$status) && e$status == 402) {

        cli::cli_text(paste0("Please visit {.url https://coeditorai.com} ",
                             "to make the subscription payment."))

        return(NULL)
      }

      if (!is.null(e$status) && e$status == 401) {

        cli::cli_alert_danger(
          "You are not properly authorized to access CoeditorAI API.")
        cli::cli_alert_info(
          "If you a new user please register your email in the 'Account' tab.")
        cli::cli_alert_info(paste0(
          "After your registered, please confirm your email address ",
          "by clicking the link in the confirmation email that has been sent ",
          "to you and set your password to the API."))
        cli::cli_alert_info(paste0(
          "If you are already registered, please make sure you set your ",
          "credentials in environmental variables: 'COEDITORAI_USER_EMAIL' ",
          "and 'COEDITORAI_USER_PASSWORD'."))

        return(NULL)
      }

      if (!is.null(e$status) && grepl(x = e$message, pattern = "Timeout")) {

        cli::cli_alert_info("The servers might be overloaded.")
        cli::cli_alert_info("Try again after few seconds.")

      }

      if (is.null(e$status)) {

        cli::cli_alert_info(paste0(
          "Please check the connection with CoeditorAI API ",
          "in the `Account` tab."))
      }

      return(NULL)
    })

  output_text
}
