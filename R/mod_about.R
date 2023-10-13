mod_about_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::layout_columns(
    fillable   = TRUE,
    fill       = FALSE,
    col_widths = bslib::breakpoints(sm = c(6, 6, 6),
                                    lg = c(4, 4, 4)),

    bslib::card(
      class = "border-dark",
      bslib::card_header("About"),

      bslib::card_body(
        fillable = FALSE,

        shiny::div(
          style = "display: block; width: 100%; text-align: center;",
          shiny::img(src    = "www/logo.png",
                     align  = "center"),
          shiny::br(),
          shiny::br(),
          shiny::markdown(paste0(
            "[![License: MIT]",
            "(https://img.shields.io/badge/license-MIT-blue.svg)]",
            "(https://cran.r-project.org/web/licenses/MIT) ",
            "[![](https://img.shields.io/badge/powered%20by-OpenAI-blue.svg)]",
            "(https://openai.com/)"
          )),
          shiny::span("Homepage: ",
                      shiny::a("CoeditorAI.com",
                               href = "https://coeditorai.com")),
          shiny::br(),
          shiny::span("E-mail: ",
                      shiny::HTML(paste0(
                        '<a href="mailto:contact@coeditorai.com">',
                        'contact@coeditorai.com</a>')))
        ),
      )
    ),

    bslib::as_fill_carrier(
      shiny::uiOutput(ns("versions"))
    ),

    bslib::card(
      full_screen = TRUE,
      fill        = FALSE,
      min_height  = "300px",
      class       = "border-dark",
      bslib::card_header("Changelog"),
      shiny::includeMarkdown(system.file(package = "CoeditorAI", "NEWS.md"))
    )
  )
}


mod_about_server <- function(input, output, session) {

  ns <- session$ns

  # output$versions #########################################################
  output$versions <- shiny::renderUI({

    versions <- get_versions()
    shiny::req(versions)

    current_version <- as.character(utils::packageVersion("CoeditorAI"))
    latest_version <- versions$r_package$github_main

    is_new_version_available <-
      ifelse(utils::compareVersion(current_version,
                                   latest_version) > -1,
             FALSE, TRUE)

    bslib::card(
      class = "border-dark",
      bslib::card_header("Versions"),
      bslib::card_body(
        fill     = TRUE,
        fillable = FALSE,
        shiny::p(
          shiny::span("API:"),
          shiny::span(class = "badge bg-info",
                      style = "float: right; margin-top: 3px;",
                      versions$api_version)),
        shiny::p(
          shiny::span("R package:")),
        shiny::p(
          shiny::span("- currently used:"),
          shiny::span(class = "badge bg-info",
                      style = "float: right; margin-top: 3px;",
                      current_version)),
        shiny::p(
          shiny::span("- GitHub@main:"),
          shiny::span(class = "badge bg-info",
                      style = "float: right; margin-top: 3px;",
                      latest_version)),
        shiny::p(
          shiny::span("- GitHub@devel:"),
          shiny::span(class = "badge bg-info",
                      style = "float: right; margin-top: 3px;",
                      versions$r_package$github_devel)),

        shiny::p(
          shiny::span("- CRAN:"),
          shiny::span(class = "badge bg-info",
                      style = "float: right; margin-top: 3px;",
                      versions$r_package$cran)),
        shiny::br(),

        {
          if (is_new_version_available) {

            bslib::value_box(
              title = "New version available!",
              value = latest_version,
              showcase = bsicons::bs_icon("exclamation-diamond"),
              theme = "primary",
              shiny::p(paste(
                "Please install the new version of the CoeditorAI R package",
                "and restart your RStudio session.")))

          } else {

            bslib::value_box(
              title = "You have the latest stable version of the package installed.",
              value = NULL,
              showcase = bsicons::bs_icon("check-lg"),
              theme = "success")
          }
        }
      ))
  })

  return(list(
  ))
}
