resourcePath <- system.file("shiny", "www", package = "SSdemo")
addResourcePath("resources", resourcePath)

tagList(
  page_navbar(
    theme = bs_theme(version = 5,
                     bootswatch = "spacelab"),
    id = "tabs",
    header = tagList(
      rintrojs::introjsUI(),
      shinyjs::useShinyjs(),
      shinyjs::extendShinyjs(
        script = file.path("resources", "js", "shinyjs-funcs.js"),
        functions = c("scrollLogger", "disableModule", "enableModule", "runOnEnter")
      ),
      tags$head(tags$link(href = "css/styles.css", rel = "stylesheet"),
    )),
    title = img(src = "logo.png", height = "50", width = "50"),
    window_title = "SSdemo",
    nav_panel("Intro", value = "intro"),
    nav_panel("Select data", value = "select"),
    nav_panel("Transform data", value = "transform"),
    nav_panel("Plot data", value = "plot"),
    nav_panel("Reproduce", value = "rep"),
    nav_menu("Support", icon = icon("life-ring"),
               HTML('<a href="https://github.com/simon-smart88/shinyscholar/issues" target="_blank">GitHub Issues</a>'),
               HTML('<a href="mailto: simon.smart@cantab.net" target="_blank">Send Email</a>')),
    nav_panel(NULL, icon = icon("power-off"), value = "_stopapp")
  ),
  layout_sidebar(
    sidebar = sidebar(
      width = 400,
      open = "always",
      div(class = "sidebar_container",
        conditionalPanel(
          "input.tabs == 'intro'",
          includeMarkdown("Rmd/text_intro_tab.Rmd")
        ),
          insert_modules_ui("select", "Select data"),
          insert_modules_ui("transform", "Transform data"),
          insert_modules_ui("plot", "Plot data"),
        insert_modules_ui("rep", "Reproduce"),
        div(class = "ss_footer",
          "Built with ",
          tags$a(href = "https://cran.r-project.org/package=shinyscholar", target = "_blank", "shinyscholar")
        )
      )
    ),
  # --- RESULTS WINDOW ---
  conditionalPanel(
    "input.tabs != 'intro' & input.tabs != 'rep'",
    layout_columns(
      col_widths = c(4, 8),
        div(
          strong("Global settings"),
          br(),
          actionButton("reset", "Delete data", icon = icon("trash")),
        ),
        div(
          div(style = "margin-top: -10px"),
          strong("Log window"),
          div(style = "margin-top: 5px"),
          div(
            id = "messageLog",
            div(id = "logHeader", div(id = "logContent"))
          )

        ,
          br(),
          textOutput("running_tasks")
        )
      )


  ),
  conditionalPanel(
    "input.tabs != 'intro' & input.tabs != 'rep'",
    navset_tab(
      id = "main",

    nav_panel(
      "Map",
      core_mapping_module_ui("core_mapping")
    ),

    nav_panel(
      "Table", br(),
      DT::dataTableOutput("table"),
      downloadButton('dl_table', "CSV file")
    ),

    nav_panel(
      "Results",
      lapply(COMPONENTS, function(component) {
        conditionalPanel(
          glue::glue("input.tabs == '{component}'"),
          insert_modules_results(component)
        )
      })
    ),
    nav_panel(
      "Component Guidance", icon = icon("circle-info"),
      flex_wrap(uiOutput('gtext_component'))
    ),
    nav_panel(
      "Module Guidance", icon = icon("circle-info", class = "mod_icon"),
      flex_wrap(uiOutput('gtext_module'))
    ),

    nav_panel(
      "Code",
      core_code_module_ui("core_code")
    ),

    nav_panel(
      "Save", icon = icon("floppy-disk", class = "save_icon"),
      flex_wrap(core_save_module_ui("core_save"))
    )
  )
),
    conditionalPanel(
      "input.tabs == 'rep' & input.repSel == null",
      flex_wrap(includeMarkdown("Rmd/gtext_rep.Rmd"))
    ),
    conditionalPanel(
      "input.tabs == 'rep' & input.repSel == 'rep_renv'",
      flex_wrap(includeMarkdown("modules/rep_renv.md"))
    ),
    conditionalPanel(
      "input.tabs == 'rep' & input.repSel == 'rep_markdown'",
      flex_wrap(includeMarkdown("modules/rep_markdown.md"))
    ),
    conditionalPanel(
      "input.tabs == 'rep' & input.repSel == 'rep_refPackages'",
      flex_wrap(includeMarkdown("modules/rep_refPackages.md"))
    ),
    conditionalPanel(
      "input.tabs == 'intro'",
      flex_wrap(
        navset_tab(
          id = 'introTabs',
          nav_panel(
            'About',
            core_intro_module_ui("core_intro"),
            # suppress logo path warning
            suppressWarnings(includeMarkdown("Rmd/text_about.Rmd"))
          ),
          nav_panel(
            'Team',
            includeMarkdown("Rmd/text_team.Rmd")
          ),
          nav_panel(
            'How To Use',
            includeMarkdown("Rmd/text_how_to_use.Rmd")
          ),
          nav_panel(
            'Load Prior Session',
            core_load_module_ui("core_load")
          )
        )
      )
    )
  )
)


