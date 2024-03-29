mod_text_coeditor_ui <- function(id) {

  ns <- shiny::NS(id)

  id_number <- stringr::str_extract(id, "\\d+")

  bslib::card(
    full_screen = TRUE,
    class       = "border-dark",
    id          = id,

    bslib::card_body(
      shiny::uiOutput(ns("input_text")),
    ),

    bslib::card_footer(
      shiny::div(
        style = "text-align: center; display: inline-block;",

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("paste"),
            label   = shiny::span(class = "button-label", "Paste"),
            icon    = shiny::icon("paste"),
            class   = "btn-success"),
          paste("Copy text and paste it the current document.",
                "If some text is currently selected, it will be replaced.",
                "If no text is selected,",
                "the text will be inserted at the cursor position."),
          options   = list(delay = 1000),
          placement = "bottom"),

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("copy"),
            label   =  "",
            icon    = shiny::icon("copy"),
            class   = "btn-success"),
          "Copy text to the clipboard.",
          options   = list(delay = 1000),
          placement = "bottom"),

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("drop"),
            label   = "",
            icon    = shiny::icon("trash-can"),
            class   = "btn-primary"),
          "Removing text from the CoeditorAI session.",
          options   = list(delay = 1000),
          placement = "bottom"),

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("rewrite"),
            label   = shiny::span(class = "button-label", "Rewrite"),
            icon    = shiny::icon("redo"),
            class   = "btn-info"),
          "Rewrite text using AI.",
          options   = list(delay = 1000),
          placement = "bottom"),

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("proofread"),
            label   = shiny::span(class = "button-label", "Proofread"),
            icon    = shiny::icon("spell-check"),
            class   = "btn-info"),
          "Proofread the text.",
          options   = list(delay = 1000),
          placement = "bottom"),

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("translate"),
            label   = shiny::span(class = "button-label", "Translate"),
            icon    = shiny::icon("language"),
            class   = "btn-info"),
          "Translate text using AI.",
          options   = list(delay = 1000),
          placement = "bottom"),

        bslib::tooltip(
          shiny::actionButton(
            inputId = ns("use_custom_prompt"),
            label   = "",
            icon    = shiny::icon("terminal"),
            class   = "btn-info"),
          "Use your own custom prompt to edit text.",
          options   = list(delay = 1000),
          placement = "bottom")

      ),
      shiny::tags$div(

        style = "text-align: center; display: inline-block; float:right;",
        shiny::tags$span(class = "badge bg-light", paste0("#", id_number))
      ),
    )
  )
}

mod_text_coeditor_server <- function(id,
                                     module_id,
                                     session_id,
                                     input_text,
                                     temperature,
                                     style,
                                     verbose = is_verbose()
                                     ) {

  shiny::moduleServer(id, function(input, output, session) {

    ns <- session$ns

    output_text <- shiny::reactiveVal(NULL)

    shiny::observeEvent(input$rewrite, {

      if (verbose) cli::cli_alert("Rewriting text...")

      output_text <- get_output_text(
        rewrite,
        text        = input_text,
        temperature = shiny::isolate(temperature()),
        style       = shiny::isolate(style()),
        session_id  = shiny::isolate(session_id()))


      if (!is.null(output_text)) output_text(output_text)
    })

    shiny::observeEvent(input$proofread, {

      if (verbose) cli::cli_alert("Proofreading text...")

      output_text <- get_output_text(
        proofread,
        text        = input_text,
        temperature = shiny::isolate(temperature()),
        session_id  = shiny::isolate(session_id()))


      if (!is.null(output_text)) output_text(output_text)
    })

    shiny::observeEvent(input$language_selected, {

      if (verbose) cli::cli_alert("Translating text...")

      shiny::removeModal()

      output_text <- get_output_text(
        translate,
        text            = input_text,
        target_language = shiny::isolate(input$language),
        temperature     = shiny::isolate(temperature()),
        session_id  = shiny::isolate(session_id()))

      if (!is.null(output_text)) output_text(output_text)
    })

    shiny::observeEvent(input$custom_prompt_provided, {

      if (verbose) cli::cli_alert("Using custom prompt to edit text...")

      shiny::removeModal()

      output_text <- get_output_text(
        custom_prompt,
        text            = input_text,
        custom_prompt = shiny::isolate(input$custom_prompt),
        temperature     = shiny::isolate(temperature()),
        session_id  = shiny::isolate(session_id()))

      if (!is.null(output_text)) output_text(output_text)
    })

    output$input_text <-
      shiny::renderUI({
        shiny::HTML(markdown::markdownToHTML(
          input_text,
          stylesheet    = NULL,
          header        = NULL,
          template      = FALSE,
          fragment.only = TRUE))
      })

    shiny::observeEvent(input$translate, {

      shiny::showModal(
        shiny::modalDialog(
          easyClose = TRUE,
          fade      = TRUE,

          shiny::p("Select target language:"),

          shiny::selectInput(
            inputId = ns("language"),
            label   = NULL,
            choices = available_languages |> sort(),
            selected = "English"),

          shiny::actionButton(
            inputId = ns("language_selected"),
            label   = "Select language",
            icon    = shiny::icon("check"),
            class   = "btn-info")
        )
      )
    })

    shiny::observeEvent(input$use_custom_prompt, {

      shiny::showModal(
        shiny::modalDialog(
          easyClose = TRUE,
          fade      = TRUE,

          shiny::p("Write your own custom prompt for AI to edit the text:"),

          shiny::textInput(
            inputId = ns("custom_prompt"),
            placeholder = "Make the text more formal.",
            label   = NULL
          ),

          shiny::actionButton(
            inputId = ns("custom_prompt_provided"),
            label   = "Submit prompt",
            icon    = shiny::icon("check"),
            class   = "btn-info")
        )
      )
    })

    shiny::observeEvent(input$paste, {

      set_selection(text = input_text)

      send_text_event(text       = input_text,
                      event_type = "INFO",
                      event_name = "Text inserted",
                      session_id  = shiny::isolate(session_id()))

      shiny::showNotification(
        ui       = "Text inserted.",
        action   = NULL,
        duration = 5,
        type     = "default")
    })

    shiny::observeEvent(input$copy, {

      clipr::write_clip(content = input_text)

      send_text_event(text       = input_text,
                      event_type = "INFO",
                      event_name = "Text copied",
                      session_id  = shiny::isolate(session_id()))

      shiny::showNotification(
        ui       = "Text copied to clipboard.",
        action   = NULL,
        duration = 5,
        type     = "default")
    })

    shiny::observeEvent(input$drop, {

      send_text_event(text       = input_text,
                      event_type = "INFO",
                      event_name = "Text deleted",
                      session_id  = shiny::isolate(session_id()))

      shiny::showNotification(
        ui       = "Text deleted.",
        action   = NULL,
        duration = 5,
        type     = "default")
    })

    return(list(
      output_text = output_text,
      drop_editor = shiny::reactive(input$drop)
    ))
  })
}
