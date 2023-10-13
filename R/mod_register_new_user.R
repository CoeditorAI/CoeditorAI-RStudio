mod_register_new_user_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::as_fill_carrier(
    shiny::uiOutput(ns("register_new_user"))
  )
}


mod_register_new_user_server <- function(input, output, session,
                                         api_is_alive,
                                         current_user
                                         ) {
  ns <- session$ns

  input_validator <- shinyvalidate::InputValidator$new()
  input_validator$add_rule("new_user_email", shinyvalidate::sv_required())
  input_validator$add_rule("new_user_email", shinyvalidate::sv_email())
  input_validator$add_rule("terms_accepted",
                           shinyvalidate::sv_equal(
                             rhs         = TRUE,
                             message_fmt = "Required!"))


  output$register_new_user <- shiny::renderUI({

    shiny::req(api_is_alive())
    shiny::req(!current_user()$is_authorized)

    input_validator$enable()

    bslib::as_fill_item(
      min_height = "130px",

      bslib::card(
        fill  = TRUE,
        class = "bg-secondary",
        bslib::card_header("Register new user"),
        bslib::card_body(
          fillable = TRUE,
          fill     = TRUE,

          shiny::textInput(
            inputId     = ns("new_user_email"),
            width       = "100%",
            placeholder = "Enter your email address",
            value       = Sys.getenv("COEDITORAI_USER_EMAIL", ""),
            label       = "Your email:"),

          shiny::checkboxInput(
            inputId = ns("terms_accepted"),
            value   = FALSE,
            label   = shiny::span(
              "I accept ",
              shiny::a(href = "https://coeditorai.com/terms_of_service.html",
                       "Terms of Service"),
              "and" ,
              shiny::a(href = "https://coeditorai.com/privacy_policy.html",
                       "Privacy Policy")

            ),
            width   = "100%"
          ),


          shiny::actionButton(inputId = ns("register_new_user"),
                              label   = "Create the account",
                              icon    = shiny::icon("user-plus"),
                              width   = "100%",
                              class   = "btn-sm")
        ),
        bslib::card_footer("No credit card required for 14 days free trial.")
      )
    )
  })

  shiny::observeEvent(input$register_new_user, {

    shiny::req(input_validator$is_valid())

    result <- add_new_user(email          = input$new_user_email,
                           terms_accepted = input$terms_accepted)

    if (result$user_added) {

      cli::cli_alert_success(cli::col_green("User registered!"))
      cli::cli_alert_info("Please check your inbox for the confirmation email.")

      shiny::showNotification(
        type     = "message",
        duration = 10,
        ui       = "User registered!",
        action   = "Please check your inbox for the confirmation email.")

    } else {

      cli::cli_alert_danger(cli::col_red("User email already registered!"))
      cli::cli_alert_info("Please check your inbox for the confirmation email.")

      shiny::showNotification(
        type     = "error",
        duration = 10,
        ui       = "Email already registered!",
        action   = "Please check your inbox for the confirmation email.")
    }

  })

}
