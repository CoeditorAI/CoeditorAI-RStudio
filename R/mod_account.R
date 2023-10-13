mod_account_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::layout_columns(
    fillable   = TRUE,
    fill       = FALSE,
    col_widths = bslib::breakpoints(sm = c(12, 12, 12),
                                    md = c(6, 6, 6)),

    mod_api_check_ui(ns("api_check")),

    mod_current_user_ui(ns("current_user")),

    mod_user_subscription_ui(ns("user_subscription")),

    mod_register_new_user_ui(ns("register_new_user"))
  )
}

mod_account_server <- function(input, output, session) {

  ns <- session$ns

  api_is_alive <- shiny::reactive({
    is_api_alive()
  })

  current_user <- shiny::reactive({
    get_current_user()
  })

  api_check_results <-
    shiny::callModule(module       = mod_api_check_server,
                      id           = "api_check",
                      api_is_alive = api_is_alive)

  current_user_results <-
    shiny::callModule(module       = mod_current_user_server,
                      id           = "current_user",
                      api_is_alive = api_is_alive,
                      current_user = current_user)

  user_subscription_results <-
    shiny::callModule(module       = mod_user_subscription_server,
                      id           = "user_subscription",
                      api_is_alive = api_is_alive,
                      current_user = current_user)

  register_new_user_results <-
    shiny::callModule(module       = mod_register_new_user_server,
                      id           = "register_new_user",
                      api_is_alive = api_is_alive,
                      current_user = current_user)
}
