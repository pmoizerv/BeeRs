# try to make a shiny app that helps with


usethis::use_package("shiny")
usethis::use_package("utils")



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
shiny::numericInput("NumberBeers", label = "Number of beers", min = 0, max = 7, step = 1, value = 0),
  shiny::actionButton()

),

    # Specifies what to put in the main panel
    shiny::mainPanel(shiny::plotOutput("plot_output",width="900px",height="700px"))

    )
  )



server <- function(input, output, session) {



  output$plot_output <- renderPlot({beers_dat |>
      tidyr::pivot_longer(4:6, values_to = "Volume", names_to = "Purpose") |>
      dplyr::filter(year %in% input$Year[1]:input$Year[2],
                    Purpose %in% COLUMN,
                    state != "total") |>
      dplyr::group_by(state, state_full) |>
      dplyr::summarise(AVG = almost(Volume/1000, N = input$NumberBeers)) |>
      dplyr::ungroup() |>

      #dplyr::mutate(AVG = ifelse(AVG == NA, 0, as.numeric(AVG))) |>
      dplyr::mutate(Total = sum(AVG, na.rm = T),
                    Percent = (AVG/Total) * 100,
                    AlmostPercent = Percent + mean(rnorm(100/(input$NumberBeers + 1), 0, input$NumberBeers)),
                    AlmostTotal = sum(AlmostPercent, na.rm = T),
                    Percent = (AlmostPercent/AlmostTotal) * 100) |>


      ggplot2::ggplot(mapping = ggplot2::aes(map_id = state_full))+
      ggplot2::geom_map(mapping = ggplot2::aes(fill = Percent), map = states_map, col = 1) +
      ggplot2::expand_limits(x = states_map$long, y = states_map$lat)+
      ggplot2::scale_fill_gradient2(high = "red", low = "blue") +

      ggplot2::theme_void() +
      ggplot2::theme(legend.position = "bottom")})




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

