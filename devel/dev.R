renv::install("usethis")
renv::install("devtools")
renv::install("testthat")

usethis::use_testthat()
usethis::use_build_ignore("devel")
usethis::edit_r_environ("project")

renv::install("openai")
renv::install("rstudioapi")

renv::install("httr2")

usethis::use_roxygen_md()


usethis::use_author(given  = "Kamil",
                    family = "Wais",
                    role   = c("aut", "cre"),
                    email  = "kamil.wais@gmail.com")

usethis::use_author(given  = "Olesia",
                    family = "Wais",
                    role   = c("aut"),
                    email  = "olesia.wais@gmail.com")

usethis::use_author("Kamil Wais InnowacjeSystemowe.pl",
                    role = c("cph", "fnd"))

usethis::use_mit_license(copyright_holder = c("Kamil Wais InnowacjeSystemowe.pl"))

renv::install("ggplot2")
renv::install("bsicons")
renv::install("DT")
bslib::bs_theme_preview()

renv::install("lorem")
renv::install("shinyjs")
renv::install("markdown")

renv::install("rclipboard")
renv::install("shinycssloaders")
renv::install("shinycustomloader")
renv::install("shinybusy")

usethis::use_package("jsonlite")
usethis::use_package("rlang")
usethis::use_package("httr2", min_version = "1.0.0")
usethis::use_package("cli")
usethis::use_package("bslib", min_version = "0.5")
usethis::use_package("bsicons")
usethis::use_package("shinyWidgets")

usethis::use_package("clipr")
usethis::use_package("markdown")
usethis::use_package("rstudioapi", min_version = "0.15")
usethis::use_package("shiny",      min_version = "1.8.0")
usethis::use_package("shinybusy")
usethis::use_package("shinyjs")
usethis::use_package("stringr")
usethis::use_package("shinyvalidate")

usethis::use_package("withr", type = "Suggests")
usethis::use_package("httptest2", type = "Suggests")
usethis::use_package("shinytest2", type = "Suggests")

usethis::use_readme_rmd()
usethis::use_news_md()

# renv::install("badger")
usethis::use_package("badger")


usethis::use_logo("devel/hex.png")
pkgdown::build_favicons(overwrite = TRUE)

usethis::use_package_doc()


# usethis::use_pkgdown()
pkgdown::build_site()

# remotes::install_github("rstudio/bslib")

# renv::install("devtools")

# renv::restore(prompt = FALSE)
renv::repair()
renv::status()
renv::upgrade()
renv::update()
renv::clean()
renv::snapshot()


usethis::use_github_action()

usethis::use_data_raw(name = "available_languages")

shinytest2::use_shinytest2()

usethis::use_version(which = "dev")

devtools::build_readme()
