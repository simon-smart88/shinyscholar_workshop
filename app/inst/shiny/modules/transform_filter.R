transform_filter_module_ui <- function(id) {
  ns <- shiny::NS(id)
  tagList(
    # UI

    actionButton(ns("run"), "Run module transform_filter", icon = icon("arrow-turn-down")),
    downloadButton(ns("download"), "Download")


  )
}

transform_filter_module_server <- function(id, common, parent_session, map) {
  moduleServer(id, function(input, output, session) {

  shinyjs::hide("download")

  observeEvent(input$run, {
    # WARNING ####

    # FUNCTION CALL ####

    # LOAD INTO COMMON ####

    # METADATA ####
    # Populate using metadata()

    # TRIGGER
    trigger("transform_filter")

    shinyjs::show("download")

  })

  output$result <- renderText({
    watch("transform_filter")
    # Result
  })

  output$download <- downloadHandler(
    filename = function() {
      "placeholder.ext"
    },
    content = function(file) {
      # Download content
    })

  return(list(
    save = function() {
      # Save any values that should be saved when the current session is saved
      # Populate using save_and_load()
    },
    load = function(state) {
      # Load
      # Populate using save_and_load()
    }
  ))

})
}


transform_filter_module_result <- function(id) {
  ns <- NS(id)

  # Result UI
  verbatimTextOutput(ns("result"))
}

transform_filter_module_map <- function(map, common) {
  # Map logic
}

transform_filter_module_rmd <- function(common) {
  # Variables used in the module's Rmd code
  # Populate using metadata()
}

