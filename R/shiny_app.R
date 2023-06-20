# try to make a shiny app that helps with
library(maps)
library(shiny)
ui <- fluidPage(

  # Application title
  titlePanel("World Population Over Time"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("beer_csv", "Beer production by", choices = NULL, multiple = T)
#      sliderInput("Year",
#                   "Year:",
#                   min = 2008,
#                   max = 2019,
#                   step = 1,
#                   sep = ",",
#                   value = 2008),

    ),

    # Specifies what to put in the main panel
    mainPanel(
      leafletOutput("mymap")
    )
  )
)



server <- function(input, output, session) {
  get_data <- reactive({
    req(input$beer_csv)
    read.csv(input$my_csv$datapath, header = TRUE)
  })

  # output$distPlot <- renderPlot({
  #    # generate bins based on input$bins from ui.R
  #    x    <- faithful[, 2]
  #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #
  #    # draw the histogram with the specified number of bins
  #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  # })

  output$map <- renderLeaflet({

    leaflet(data = mapStates) %>% addTiles(mapStates$names=="alabama") %>%
      addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
    # Put three lines of leaflet code here



  })

}

shinyApp(ui = ui, server = server)
