# try to make a shiny app that helps with


usethis::use_package("shiny")
usethis::use_package("utils")
use



ui <- shiny::fluidPage(


  # Application title
  shiny::titlePanel("World Population Over Time"),

  # Sidebar with a slider input for number of bins
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::sliderInput("Year",
                   "Year:",
                   min = 2008,
                   max = 2019,
#                   step = 1,
                   sep = "",
                   value = c(2008,2019)),
  shiny::submitButton()
),

    # Specifies what to put in the main panel
    shiny::mainPanel(plotOutput("plot_output",width="900px",height="700px"))

    )
  )



server <- function(input, output, session) {



  output$plot_output <- renderPlot({beers_dat |>
      tidyr::pivot_longer(4:6, values_to = "Volume", names_to = "Purpose") |>
      dplyr::filter(year %in% input$Year[1]:input$Year[2],
                    Purpose %in% COLUMN,
                    state != "total") |>
      dplyr::group_by(state, state_full) |>
      dplyr::summarise(AVG = almost(Volume, N = NumberBeers)) |>
      dplyr::ungroup() |>

      #dplyr::mutate(AVG = ifelse(AVG == NA, 0, as.numeric(AVG))) |>
      dplyr::mutate(Total = sum(AVG, na.rm = T),
                    Percent = (AVG/Total) * 100) |>

      ggplot2::ggplot(mapping = ggplot2::aes(map_id = state_full))+
      ggplot2::geom_map(mapping = ggplot2::aes(fill = Percent), map = states_map) +
      ggplot2::expand_limits(x = states_map$long, y = states_map$lat)})




  # output$distPlot <- renderPlot({
  #    # generate bins based on input$bins from ui.R
  #    x    <- faithful[, 2]
  #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #
  #    # draw the histogram with the specified number of bins
  #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  # })



}

shiny::shinyApp(ui = ui, server = server)
