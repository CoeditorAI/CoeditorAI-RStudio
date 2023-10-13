get_selection <- function() {

  if (rstudioapi::isAvailable()) {

    rstudioapi::selectionGet()$value

  } else {

    "RStudio is not running."
  }
}

set_selection <- function(text) {

  rstudioapi::selectionSet(value = text)
}
