add_new_user <- function(email,
                         terms_accepted,
                         dry_run    = FALSE,
                         debug      = FALSE) {

  request <-
    create_post_api_request() |>
    httr2::req_url_path_append("user") |>
    httr2::req_body_json(list(email          = email,
                              terms_accepted = terms_accepted))

  if (debug) print_debug_info(request)
  if (dry_run) return(invisible(request))

  tryCatch({

    response <-
      request |>
      httr2::req_perform()

    response_body <-
      response |>
      httr2::resp_body_json(simplifyVector = TRUE)

    response_body

  }, error = function(e) {

    return(list(
      e$message
    ))
  })
}

