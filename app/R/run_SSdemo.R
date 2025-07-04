#' @title Run \emph{"SSdemo"} Application
#' @description This function runs the \emph{"SSdemo"} application in the user's
#' default web browser.
#' @param launch.browser Whether or not to launch a new browser window.
#' @param port The port for the shiny server to listen on. Defaults to a
#' random available port.
#' @param load_file Path to a saved session file which will be loaded when the 
#' app is opened
#' @returns No return value, called for side effects
#' @examples
#' if(interactive()) {
#' run_SSdemo()
#' }
#' @author Jamie Kass <jkass@@gradcenter.cuny.edu>
#' @author Gonzalo E. Pinilla-Buitrago <gpinillabuitrago@@gradcenter.cuny.edu>
#' @author Simon E. H. Smart <simon.smart@@cantab.net>
#' @export
run_SSdemo <- function(launch.browser = TRUE, port = getOption("shiny.port"), load_file = NULL) {

  if (!is.null(load_file) && !file.exists(load_file)){
    stop("The specified load_file does not exist")
  }
  
  # Store the load_file path to make it accessible inside the app
  .GlobalEnv$load_file_path <- if (!is.null(load_file) && file.exists(load_file)) {
    load_file
  } else {
    NULL
  }
  
  app_path <- system.file("shiny", package = "SSdemo")
  knitcitations::cleanbib()
  options("citation_format" = "pandoc")
  preexisting_objects <- ls(envir = .GlobalEnv)
  on.exit(rm(list = setdiff(ls(envir = .GlobalEnv), preexisting_objects), envir = .GlobalEnv))
  shiny::runApp(app_path, launch.browser = launch.browser, port = port)
}

