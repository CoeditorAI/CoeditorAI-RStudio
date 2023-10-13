send_text_event <- function(text,
                            event_name,
                            event_type = "INFO",
                            dry_run    = FALSE,
                            debug      = FALSE,
                            ...
                            ) {
  request <-
    create_post_api_request(input_text_id = rlang::hash(text), ...) |>
    httr2::req_url_path_append("event")

  request <-
    request |>
    httr2::req_body_json(c(request$body$data,
                           list(event_name = event_name,
                                event_type = event_type)))

  if (debug) print_debug_info(request)
  if (dry_run) return(invisible(request))

  response <-
    request |>
    httr2::req_perform()

  response
}
