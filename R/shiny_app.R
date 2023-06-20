# try to make a shiny app that helps with
<<<<<<< HEAD
library(maps)
library(shiny)
ui <- fluidPage(
=======
usethis::use_package("shiny")
usethis::use_package("leaflet")
usethis::use_package("utils")
usethis::use_package("grDevices")


ui <- shiny::fluidPage(
>>>>>>> 80f0e7c43f4dd19d8752ab61fe7ccebc0d85b292

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
<<<<<<< HEAD
  get_data <- reactive({
    req(input$beer_csv)
    read.csv(input$my_csv$datapath, header = TRUE)
=======
  get_data <- shiny::reactive({
    shiny::req()
    utils::read.csv(input$my_csv$datapath, header = TRUE)
>>>>>>> 80f0e7c43f4dd19d8752ab61fe7ccebc0d85b292
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

<<<<<<< HEAD
    leaflet(data = mapStates) %>% addTiles(mapStates$names=="alabama") %>%
      addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
=======
    leaflet::leaflet(data = mapStates) %>%
      leaflet::addTiles(mapStates$names=="alabama") %>%
      leaflet::addPolygons(fillColor = grDevices::topo.colors(10, alpha = NULL), stroke = FALSE)
>>>>>>> 80f0e7c43f4dd19d8752ab61fe7ccebc0d85b292
    # Put three lines of leaflet code here



  })

}

shinyApp(ui = ui, server = server)
