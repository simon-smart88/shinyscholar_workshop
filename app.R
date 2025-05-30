library(gargoyle)
library(shiny)

ui <- function(){
  fluidPage(
  actionButton("go", "go"),
  verbatimTextOutput("out1"),
  verbatimTextOutput("out2"),
  verbatimTextOutput("out3"),
  plotOutput("plot1"),
  plotOutput("plot2"),
  plotOutput("plot3")
  )
}

server <- function(input, output, session){

  new_watch <- function(name, session = getDefaultReactiveDomain()){
    req(session$userData[[name]]() > 0)
  }

  init("a")

  b <- new.env()

  observeEvent(input$go, {
    b$b <- "testing1"
    b$p <- rnorm(100)
    trigger("a")
  })

  output$out1 <- renderText({
    watch("a")
    b$b
  })

  output$out2 <- renderText({
    watch("a")
    "testing2"
  })

  output$out3 <- renderText({
    new_watch("a")
    "testing3"
  })

  output$plot1 <- renderPlot({
    watch("a")
    hist(b$p, main = "1")
  })
  
  output$plot2 <- renderPlot({
    new_watch("a")
    hist(rnorm(100), main = "2")
  })

  output$plot3 <- renderPlot({
    watch("a")
    hist(rnorm(100), main = "3")
  })

}

shinyApp(ui, server)

### ** Examples

  # library(shiny)
  # library(gargoyle)
  # options("gargoyle.talkative" = TRUE)
  # 
  #   new_watch <- function(name, session = getDefaultReactiveDomain()){
  #     req(session$userData[[name]]() > 0)
  #   }
  # 
  # ui <- function(request){
  #   tagList(
  #     h4('Go'),
  #     actionButton("y", "y"),
  #     h4('Output of z$v'),
  #     tableOutput("evt")
  #   )
  # }
  # 
  # server <- function(input, output, session){
  # 
  #   # Initiating the flags
  #   init("airquality")
  #   init("iris")
  #   init("renderiris")
  # 
  #   # Creating a new env to store values, instead of
  #   # a reactive structure
  #   z <- new.env()
  # 
  #   observeEvent( input$y , {
  #     z$v <- mtcars
  #     # Triggering the flag
  #     trigger("airquality")
  #   })
  # 
  #   on("airquality", {
  #     # Triggering the flag
  #     z$v <- airquality
  #     trigger("iris")
  #   })
  # 
  #   on("iris", {
  #     # Triggering the flag
  #     z$v <- iris
  #     trigger("renderiris")
  #   })
  # 
  #   output$evt <- renderTable({
  #     # This part will only render when the renderiris
  #     # flag is triggered
  #     new_watch("renderiris")
  #     head(z$v)
  #   })
  # 
  # }
  # 
  # shinyApp(ui, server)
