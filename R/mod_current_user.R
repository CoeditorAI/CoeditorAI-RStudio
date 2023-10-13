mod_current_user_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::as_fill_carrier(
    shiny::uiOutput(ns("current_user_box"))
  )
}


mod_current_user_server <- function(input, output, session,
                                    api_is_alive,
                                    current_user
                                    ) {
  ns <- session$ns

  output$current_user_box <- shiny::renderUI({

    api_alive <- api_is_alive()
    if (!isTRUE(api_alive)) return()

    current_user_email <- Sys.getenv("COEDITORAI_USER_EMAIL")
    current_user       <- current_user()

    bslib::as_fill_item(
      min_height = "130px",
      bslib::value_box(
        title           = "User Account",
        value           = shiny::span(current_user_email,
                                      style = "font-size: 1em;"),
        theme_color     = ifelse(isTRUE(current_user$email_verified),
                                 "success", "danger"),
        showcase        = bsicons::bs_icon("person-circle"),
        showcase_layout = bslib::showcase_left_center(),
        full_screen     = FALSE,
        fill            = TRUE,
        {
          if (isFALSE(current_user$is_authorized)) {

            shiny::span(
              style = "font-size: 1em;",
              bsicons::bs_icon("exclamation-triangle"),
              "User not authorized!",
              "Please set up your credentials in environmental variables",
              "or register as a new user.")

          } else {

            shiny::span(bsicons::bs_icon("check2-circle"),
                        "User authenticated")
          }
        }
      )
    )
  })

}
