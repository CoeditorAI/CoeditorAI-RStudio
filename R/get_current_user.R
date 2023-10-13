get_current_user <- function() {

  request <-
    create_get_api_request() |>
    httr2::req_url_path_append("user")

  tryCatch({

    response <-
      request |>
      httr2::req_perform()

    current_user <-
      response |>
      httr2::resp_body_json(simplifyVector = TRUE)

    current_user$is_authorized <- TRUE

    current_user

  }, error = function(e) {

    return(list(
      is_authorized = FALSE
    ))
  })
}
