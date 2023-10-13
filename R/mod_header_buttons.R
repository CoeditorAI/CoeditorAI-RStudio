mod_header_buttons_ui <- function(id) {

  ns <- shiny::NS(id)

  header_button_width <- "19.1%"

  shiny::div(
    class = "bg-light",
    style = paste(
      "position: fixed; z-index: 100;",
      "width: 100%; text-align: center; dislay:block;",
      "padding-top: 2px;",
      "border-bottom: 1px solid lightgray; padding-bottom: 2px;"),

    bslib::tooltip(
      shiny::actionButton(inputId = ns("restart"),
                          label   = shiny::span(class = "button-label",
                                                "Restart"),
                          icon    = shiny::icon("repeat"),
                          width   = header_button_width,
                          class   = "btn-sm"),
      "Restart CoeditorAI session using current text selection.",
      options   = list(delay = 1000),
      placement = "bottom"),

    bslib::tooltip(
      shiny::actionButton(inputId = ns("scroll_top"),
                          label   = shiny::span(class = "button-label",
                                                "Top"),
                          width   = header_button_width,
                          class   = "btn-sm",
                          icon    = shiny::icon("chevron-up")),
      "Scroll to top.",
      options   = list(delay = 1000),
      placement = "bottom"),

    bslib::tooltip(
      shiny::actionButton(inputId = ns("scroll_bottom"),
                          label   = shiny::span(class = "button-label",
                                                "Bottom"),
                          width   = header_button_width,
                          class   = "btn-sm",
                          icon = shiny::icon("chevron-down")),
      "Scroll to bottom.",
      options   = list(delay = 1000),
      placement = "bottom"),

    bslib::tooltip(
      shiny::actionButton(inputId = ns("add_footer"),
                          label   = shiny::span(class = "button-label",
                                                "Add footer"),
                          width   = header_button_width,
                          class   = "btn-sm btn-success",
                          icon = shiny::icon("signature")),
      "Adding footer text with information about CoeditorAI.",
      options   = list(delay = 1000),
      placement = "bottom"),

    bslib::tooltip(
      shiny::actionButton(inputId = ns("done"),
                          label   = shiny::span(class = "button-label",
                                                "Exit"),
                          icon    = shiny::icon("power-off"),
                          width   = header_button_width,
                          class   = "btn-sm"),
      "End the CoeditorAI session.",
      options   = list(delay = 1000),
      placement = "bottom")
  )
}

mod_header_buttons_server <- function(input, output, session,
                                      session_id,
                                      last_output_text,
                                      editors_counter
                                      ) {
  ns <- session$ns

  # observe input$restart #####################################################
  shiny::observeEvent(input$restart, {

    current_selection <- get_selection()
    if (!is_selected_text_valid(current_selection)) return(invisible(NULL))

    last_output_text(current_selection)
    session_id(rlang::hash(current_selection))

    n_editors <- editors_counter()
    for (i in 1:n_editors) {

      editor_id <- paste0("text_editor_", i)
      shiny::removeUI(selector = paste0("#", editor_id))
    }
    editors_counter(editors_counter() + 1)
  })

  # observe input$scroll_* ##################################################
  shiny::observeEvent(input$scroll_top, {

    shinyjs::runjs(
      'document.getElementById("page_top_text_editors").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_top_settings").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_top_qanda").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_top_about").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_top_account").scrollIntoView();')
  })

  shiny::observeEvent(input$scroll_bottom, {

    shinyjs::runjs(
      'document.getElementById("page_bottom_text_editors").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_bottom_settings").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_bottom_qanda").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_bottom_about").scrollIntoView();')

    shinyjs::runjs(
      'document.getElementById("page_bottom_account").scrollIntoView();')
  })

  # observe input$add_footer ##################################################
  shiny::observeEvent(input$add_footer, {

    context         <- rstudioapi::getActiveDocumentContext()
    cursor_position <- context$selection[[1]]$range$end
    cursor_position <-
      rstudioapi::as.document_position(c(cursor_position[[1]] + 1, 1))

    footer_text <-
      paste0("\n\nText improved with the help of \u2764\uFE0F",
             "[CoeditorAI.com](https://coeditorai.com ",
             "'Write analytical texts faster that read better!')",
             " \u2764\uFE0F\n\n")

    rstudioapi::insertText(text     = footer_text,
                           location = cursor_position)

    send_text_event(text       = footer_text,
                    event_type = "INFO",
                    event_name = "Footer inserted",
                    session_id  = shiny::isolate(session_id()))

    shiny::showNotification(
      ui       = "Footer inserted.",
      action   = NULL,
      duration = 5,
      type     = "default")
  })

  # observe input$done ######################################################
  shiny::observeEvent(input$done, {
    shiny::stopApp(returnValue = invisible(last_output_text()))
  })

  return(list(
    restart = shiny::reactive(input$restart)
  ))
}
