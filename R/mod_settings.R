mod_settings_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::layout_columns(
    fillable   = TRUE,
    fill       = FALSE,
    col_widths = bslib::breakpoints(sm = c(6, 6, 6),
                                    lg = c(4, 4, 4)),

    # AI creativity ###########################################################
    bslib::card(
      class      = "border-dark",
      min_height = "130px",
      fill       = FALSE,
      bslib::card_header(
        "AI creativity",
        bslib::tooltip(
          trigger = bsicons::bs_icon("info-circle"),
          "Lower values result in more consistent outputs,",
          "while higher values generate more diverse and creative results.",
          "The value of 1 is the default."
        )
      ),
      bslib::card_body(
        shiny::div(
          style =
            "width: 100%; display: block; text-align: -webkit-center;",
          shiny::sliderInput(
            inputId = ns("temperature"),
            label   = NULL,
            min     = 0,
            max     = getOption("coeditorai.temperature_max", 1.5),
            ticks   = FALSE,
            value = getOption("coeditorai.temperature", 1),
            step    = 0.1)
        ))),


    # style ###################################################################
    bslib::card(
      class      = "border-dark",
      min_height = "130px",
      fill       = FALSE,
      bslib::card_header(
        "Rewrite style",
        bslib::tooltip(
          trigger = bsicons::bs_icon("info-circle"),
          "When set to 'default' the Coeditor",
          "will try to not impose any writing style."
        )),
      bslib::card_body(
        shiny::div(
          style =
            "width: 100%; display: block; text-align: -webkit-center;",
          shiny::selectizeInput(
            inputId  = ns("style"),
            label    = NULL,
            choices  = c("default", "formal", "informal"),
            selected = getOption("coeditorai.style", "default"))
        )
      )
    ),

    # dark mode ###############################################################
    bslib::card(
      class      = "border-dark",
      min_height = "130px",
      fill       = FALSE,
      bslib::card_header("Dark mode"),
      bslib::card_body(
        shiny::div(
          style =
            "width: 100%; display: block; text-align: -webkit-center;",
          shinyWidgets::switchInput(
            inputId  = ns("dark_mode"),
            value    = getOption("coeditorai.dark_mode", FALSE),
            onLabel  = "dark",
            offLabel = "light"
          ))))

  )
}

mod_settings_server <- function(input, output, session
                                ) {
  ns <- session$ns

  shiny::observeEvent(input$temperature, {
    options(coeditorai.temperature = input$temperature)
  })

  shiny::observeEvent(input$style, {
    options(coeditorai.style = input$style)
  })

  shiny::observeEvent(input$dark_mode, {
    options(coeditorai.dark_mode = input$dark_mode)
  })

  return(list(
    temperature = shiny::reactive(input$temperature),
    style       = shiny::reactive(input$style),
    dark_mode   = shiny::reactive(input$dark_mode)
  ))
}
