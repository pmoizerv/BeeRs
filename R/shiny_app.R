# try to make a shiny app that helps with

ui <- fluidPage(

  # Application title
  titlePanel("World Population Over Time"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       sliderInput("Year",
                   "Year:",
                   min = 2008,
                   max = 2019,
                   step = 1,
                   sep = ",",
                   value = 2008),

    ),

    # Specifies what to put in the main panel
    mainPanel(
      leafletOutput("mymap")
    )
  )
)



server <- function(input, output) {

  # output$distPlot <- renderPlot({
  #    # generate bins based on input$bins from ui.R
  #    x    <- faithful[, 2]
  #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #
  #    # draw the histogram with the specified number of bins
  #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  # })

  output$map <- renderLeaflet({
    # Put three lines of leaflet code here



  })

}

shinyApp(ui = ui, server = server)
