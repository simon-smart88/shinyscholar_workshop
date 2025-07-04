core_code_module_ui <- function(id) {
  ns <- shiny::NS(id)
  tagList(
    radioButtons(ns("code_choice"), "Choose file", 
                 choices = c("Module", "Function", "Markdown"), selected = "Module"),
    shinyAce::aceEditor(ns("code_module"), value = "Please select a module",
                        mode = "r",
                        theme = "crimson-code",
                        readOnly = TRUE)
  )
}

core_code_module_server <- function(id, common, module) {
  moduleServer(id, function(input, output, session) {
    observe({
      req(module != "")
      req(module != "intro")
      if (input$code_choice == "Module"){
        code <- readLines(system.file(glue("shiny/modules/{module}.R"),package = "SSdemo"))
      }
      if (input$code_choice == "Function"){
        func <- getFromNamespace(module, ns = "SSdemo")
        code <- deparse(func)
        if (length(code) == 0){
          code <- "There is no function for this module"
        } else {
          code[1] <- gsub("function", paste0(module, " <- function"), code[1])
        }
      }
      if (input$code_choice == "Markdown"){
        if (file.exists(system.file(glue::glue("shiny/modules/{module}.Rmd"), package = "SSdemo"))){
          code <- readLines(system.file(glue::glue("shiny/modules/{module}.Rmd"), package = "SSdemo"))
        } else {
          code <- "There is no markdown file for this module"
          }
      }
      out <- paste(code, collapse = "\n")
      shinyAce::updateAceEditor(session, "code_module", value = out)
    })
  })
}

