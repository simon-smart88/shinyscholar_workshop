core_intro_module_ui <- function(id) {
  ns <- shiny::NS(id)
  tagList(
    tags$div(
      style="text-align: center; padding: 20px;",
      actionButton(ns("intro"), "Start a guided tour", icon = icon("person-hiking", lib = "font-awesome"), width = "400px", style = "font-size: 2rem;")
    )
  )
}

core_intro_module_server <- function(id, common, parent_session) {
  moduleServer(id, function(input, output, session) {

  #Steps in the introduction - the element to tag, the message to display, position of the tooltip, any javascript needed to move between tabs / click buttons
  steps <- data.frame(c(NA, "Welcome to SSdemo! This tour will show you various features of the application to help get you started", NA, NA),
                      c("aside[class=\"sidebar\"]", "This panel shows all of the possible steps in the analysis", "bottom", NA),
                      c("a[data-value=\"How To Use\"]", "Detailed instructions can be found in the How To Use tab", "bottom","$('a[data-value=\"How To Use\"]').trigger('click');"),
                      c("a[data-value=\"select\"]", "Click on the tabs to move between components", "bottom", "$('a[data-value=\"select\"]').trigger('click');"),
                      c("#selectHelp", "Click on the question mark to view instructions for the component", "bottom", "$('a[data-value=\"Component Guidance\"]').trigger('click');"),
                      c("#selectSel", "Select a module to load the options", "bottom", "$('a[data-value=\"Map\"]').trigger('click');
                                                                                                     $('input[value=\"select_async\"]').trigger('click');"),
                      c("#select_asyncHelp", "Click on the question mark to view instructions for the module", "bottom", "$('a[data-value=\"Module Guidance\"]').trigger('click');"),

                      c("div[class=\"form-group shiny-input-container\"]", "Choose from the list of options", "bottom", "$('a[data-value=\"Map\"]').trigger('click');"),
                      c("#select_async-run", "Click the button or press the Enter key to run the module", "bottom", NA),
                      c("a[data-value=\"Map\"]", "Outputs will be loaded onto the Map...", "bottom", NA),
                      c("a[data-value=\"Table\"]", "or the Table...", "bottom", "$('a[data-value=\"Table\"]').trigger('click');"),
                      c("a[data-value=\"Results\"]", "or the Results tabs depending on the module", "bottom", "$('a[data-value=\"Results\"]').trigger('click');"),




                      c("div[id=\"messageLog\"]", "Messages will appear in the log window", "bottom", NA),

                      c("a[data-value=\"Code\"]", "You can view the source code for the module", "left","$('a[data-value=\"Code\"]').trigger('click');"),
                      c("a[data-value=\"rep\"]", "You can download code to reproduce your analysis in the Session Code module", "bottom","$('a[data-value=\"rep\"]').trigger('click');
                                                                                                                                          $('input[value=\"rep_markdown\"]').trigger('click');"),


                      c("a[data-value=\"select\"]", "When you are inside an analysis component...","bottom", "$('a[data-value=\"select\"]').trigger('click');"),
                      c("a[data-value=\"Save\"]", "you can download a file which saves the state of the app", "left", "$('a[data-value=\"Save\"]').trigger('click');"),
                      c("a[data-value=\"intro\"]", "Next time you visit...", "bottom", "$('a[data-value=\"intro\"]').trigger('click');"),
                      c("a[data-value=\"Load Prior Session\"]", "you can upload the file to restore the app", "left","$('a[data-value=\"Load Prior Session\"]').trigger('click');"),
                      c(NA, "You are ready to go!", NA, "$('a[data-value=\"About\"]').trigger('click');")
                                                         
  )
  #transpose and add columns names
  steps <- as.data.frame(t(steps))
  colnames(steps) <- c("element", "intro", "position", "javascript")
  
  #extract the javascript into one string
  intro_js <- ""
  for (r in 1:nrow(steps)){
    if (!is.na(steps$javascript[r])){
      intro_js <- paste(intro_js, paste0("if (this._currentStep == ",r-1,") {",steps$javascript[r],"}"))
    }
  }
  intro_js <- gsub("[\r\n]", "", intro_js)
  
  #launch intro if the button is clicked
  observeEvent(input$intro,{
    rintrojs::introjs(session, options = list(steps = steps, "showBullets" = "true", "showProgress" = "true",
                                              "showStepNumbers" = "false", "nextLabel" = "Next", "prevLabel" = "Prev", "skipLabel" = "Skip"),
                      events = list(onbeforechange = I(intro_js))
               )})

  })
}

