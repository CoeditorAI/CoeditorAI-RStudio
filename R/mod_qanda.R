mod_qanda_ui <- function(id) {

  ns <- shiny::NS(id)

  bslib::layout_columns(
    col_widths = 12,fill = FALSE, fillable = FALSE,

    bslib::accordion(
      id       = ns("q_and_a"),
      multiple = FALSE,
      open     = FALSE,

      bslib::accordion_panel(
        title = "How to set up user credentials?",

        shiny::p("Once you register as a new user, confirm your email address,",
                 "and set your password, you can set up your credentials",
                 "using environmental variables."),
        shiny::p("The recommended way is to set up the following",
                 "environmental variables in your .Renviron file:",
                 "`COEDITOR_USER_EMAIL` and `COEDITOR_USER_PASSWORD`."),
        shiny::p("For example your .Renviron file could look like this:"),
        shiny::tags$code("COEDITOR_USER_EMAIL=my_email@gmail.com"),
        shiny::tags$br(),
        shiny::tags$code("COEDITOR_USER_PASSWORD=my_password_sdgsdgf0434r52"),
        shiny::tags$br(),
        shiny::tags$br(),
        shiny::p(
          "Setting credentials in your .Renviron file is one-time job.",
          "They environmental variable will be availble in your",
          "R session after you restart R. You can open your project",
          ".Renviron file by running the following code in your R session:"),
        shiny::tags$code("usethis::edit_r_environ('project')"),
        shiny::tags$br(),
        shiny::tags$br(),
        shiny::p(
          "Alternatively, you can set up your credentials in your R session",
          "using the following code:"),
        shiny::tags$code(
          "Sys.setenv(COEDITOR_USER_EMAIL = 'my_email@gmail.com')"),
        shiny::tags$br(),
        shiny::tags$code(
          "Sys.setenv(COEDITOR_USER_PASSWORD = 'my_password_sdgsdgf0434r52')"),
        shiny::tags$br(),
        shiny::tags$br(),
        shiny::p("However this method you will have to repeat",
                 "every time you restart R."),
      ),

      bslib::accordion_panel(
        title = "How is CoeditorAI founded?",

        shiny::p(
          "Every improvement we make to `CoeditorAI` is founded by",
          "subscriptions from users like you.",
          "We don't sell your data and we never will."),
        shiny::p(
          "We understand the frustration of dealing with writing difficulties,",
          "so we have developed this tool to assist us in overcoming",
          "those challenges. Now, we are eager to extend this useful",
          "resource to others."),
        shiny::p(
          "We want to share the costs of using AI for text editing purposes,",
          "while keeping them at affordable levels for everyone.",
          "That's way we decided to try the hybrid open-source/business model,",
          "where users subscriptions play a vital role",
          "and the long-term development is user-founded and user-centered.")
      ),

      bslib::accordion_panel(
        title = "What usage data do you collect and why?",

        shiny::p(
          "Our goal is to further develop CoeditorAI using a data-driven",
          "approach. We need to determine what works and what doesn't,",
          "as well as what is frequently used and what is not. Therefore,",
          "we need to study how users utilize our product and interact",
          "with it. To achieve this, we collect non-sensitive usage",
          "meta-data such as session IDs, features, and settings used."),

        shiny::p(
          "We don't store and analyze the texts that you send to our API",
          "via the CoeditorAI Addin. We simply calculate the hashes of the",
          "texts to identify if you are working with different texts,",
          "as well as the text metadata, such as the number of words or",
          "characters. It helps us to understand how users use the",
          "CoeditorAI Add-in and API so that we can optimize the backend",
          "and keep the costs low.")
      ),

      bslib::accordion_panel(
        title = "Are there any usage limits?",

        shiny::p(
          "Technically, yes. We need to protect other users from those",
          "who want to abuse our API, so please expect that non-standard",
          "usage will be limited. However, we don't want to introduce",
          "any usage limit that can break a standard writing workflow,",
          "especially in the paid subscription plans.",
          "Our goal is to provide the best user experience",
          "without unnecessary limitations.")
      )
    ),

    shiny::p(
      style = "text-align: right;",
      "If you didn't find the answer to your question here, ",
      shiny::br(),
      "please reach out to us via email: ",
      shiny::HTML(paste0('<a href="mailto:contact@coeditorai.com">',
                         'contact@coeditorai.com</a>')),
      shiny::br(),
      shiny::br(),
      "We would love to hear from you!",
      shiny::br(),
      "Olesia & Kamil")
    )
}
