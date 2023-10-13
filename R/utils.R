is_selected_text_valid <- function(text) {

  if (text == "") {

    cli::cli_alert_danger(cli::col_red("No text selected!"))
    cli::cli_alert_info("Open a file and select text to edit.")
    return(FALSE)
  }

  return(TRUE)
}

insert_top_space <- function(id) {

  shiny::tags$div(id    = paste0("page_top_", id),
                  style = "display: block; width: 100%; height: 30px;")
}

insert_bottom_space <- function(id) {

  shiny::tags$div(id    = paste0("page_bottom_", id),
                  style = "display: block; width: 100%; height: 70px;")
}

check_user_credentials <- function() {

  if (Sys.getenv("COEDITORAI_USER_EMAIL") == "")
    cli::cli_alert_danger(cli::col_red(
      "The 'COEDITORAI_USER_EMAIL' environmental variable is not set!"
    ))

  if (Sys.getenv("COEDITORAI_USER_PASSWORD") == "")
    cli::cli_alert_danger(cli::col_red(
      "The 'COEDITORAI_USER_PASSWORD' environmental variable is not set!"
    ))

  if (Sys.getenv("COEDITORAI_USER_EMAIL") == "" ||
      Sys.getenv("COEDITORAI_USER_PASSWORD") == "") {

    cli::cli_alert_info(
      "Please see `How to set up user credentials?` in the `Q&A` section.")
  }
}
