#' ---
#' title: setup.R
#' author: David M. Freestone (freestoned@wpunj.edu)
#' date: "2020.07.20"
#' purpose:
#' ---
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'
#'@export
setup <- function() {
  install.packages("devtools")
  install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
  github_packages <- c("tidyverse/tidyverse",
                       "paul-buerkner/brms",
                       "stan-dev/shinystan",
                       "mjskay/tidybayes",
                       "lme4/lme4",
                       "hrbrmstr/dtupdate",
                       "wch/extrafont",
                       "r-lib/fs",
                       "RcppCore/Rcpp",
                       "jtextor/dagitty/r",
                       "freestone-lab/TSLibrary/TSLib",
                       "stan-dev/cmdstanr",
                       "wilkelab/cowplot",
                       "crsh/papaja",
                       "r-dbi/DBI",
                       "r-dbi/RSQLite")

  devtools::install_github(github_packages)

  # This makes stan faster
  dotR <- file.path(Sys.getenv("HOME"), ".R")
  if (!file.exists(dotR)) dir.create(dotR)
  M <- file.path(dotR, ifelse(.Platform$OS.type == "windows", "Makevars.win", "Makevars"))
  if (!file.exists(M)) file.create(M)
  cat("\nCXX14FLAGS=-O3 -march=native -mtune=native",
      if( grepl("^darwin", R.version$os)) "CXX14FLAGS += -arch x86_64 -ftemplate-depth-256" else
        if (.Platform$OS.type == "windows") "CXX11FLAGS=-O3 -march=corei7 -mtune=corei7" else
          "CXX14FLAGS += -fPIC",
      file = M, sep = "\n", append = TRUE)

  # This imports better fonts
  extrafont::font_import()
  cmdstanr::install_cmdstan()

  # Check the cmdstan version
  cmdstanr::cmdstan_version()
}

#' @export
update <- function() {
  update.packages(ask = FALSE)
  dtupdate::github_update(auto.install = TRUE, ask = FALSE)
}
