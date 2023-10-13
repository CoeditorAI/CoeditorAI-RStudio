rewrite <- function(text,
                    style       = "default",
                    temperature = 1L,
                    dry_run    = FALSE,
                    debug      = FALSE,
                    ...
                    ) {

  request <-
    create_post_api_request(input_text_id = rlang::hash(text), ...) |>
    httr2::req_url_path_append("rewrite")

  request <-
    request |>
    httr2::req_body_json(c(request$body$data,
                           list(text        = text,
                                style       = style,
                                temperature = temperature)))

  if (debug) print_debug_info(request)
  if (dry_run) return(invisible(request))

  response <-
    request |>
    httr2::req_perform()

  output_text <-
    response |>
    httr2::resp_body_json(simplifyVector = TRUE)

  output_text
}
