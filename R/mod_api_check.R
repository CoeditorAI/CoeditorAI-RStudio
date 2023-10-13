mod_api_check_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::as_fill_carrier(
    shiny::uiOutput(ns("is_api_alive"))
  )
}


mod_api_check_server <- function(input, output, session,
                                 api_is_alive = api_is_alive
                                 ) {
  ns <- session$ns

  output$is_api_alive <- shiny::renderUI({

    api_alive <- api_is_alive()

    bslib::as_fill_item(
      min_height = "130px",

      bslib::value_box(
        title       = "CoeditorAI API" ,
        value       = shiny::span(get_api_url(), style = "font-size: 1em;"),
        theme_color = ifelse(
          isTRUE(api_alive), "success", "danger"),
        showcase = {
          if (isTRUE(api_alive)) {
            bsicons::bs_icon("plug")
          } else {
            bsicons::bs_icon("exclamation-triangle")
          }
        },
        showcase_layout = bslib::showcase_left_center(),
        full_screen     = FALSE,
        fill            = FALSE,

        shiny::span(
          style = "font-size: 1em;",
          {
            if (isTRUE(api_alive)) {
              shiny::span(bsicons::bs_icon("check2-circle"),
                          "Connected")
            } else {
              shiny::span(bsicons::bs_icon("exclamation-triangle"),
                          "NOT connected!")
            }
          })
      )
    )
  })

}
