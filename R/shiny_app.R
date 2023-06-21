

  # try to make a shiny app that helps with
  usethis::use_package("shiny")
  usethis::use_package("utils")
  usethis::use_package("colourpicker")
  usethis::use_package("ggplot2")

  states_map <- ggplot2::map_data("state")
  world_map <- ggplot2::map_data("world") %>%
    dplyr::filter(! long > 180)
  Region <- world_map$region %>% unique()


  ui <- shiny::fluidPage(
    # Application title

    shiny::titlePanel("Beer production by state"),
    # Sidebar with a slider input for number of bins

    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::sliderInput("Year",
                           "Year:",
                           min = 2008,
                           max = 2019,
                           sep = "",
                           value = c(2008,2019)),
        shiny::numericInput("NumberBeers", label = "Number of beers", min = 0, max = 7, step = 1, value = 0),
        shiny::selectInput("Column", label = "Type of consumption", choices = c("BottlesCans", "Permises", "KegsBarrels"), multiple = T, selected = "Permises"),
        colourpicker::colourInput("Max", label = "Max value", value = "red"),
        colourpicker::colourInput("Min", label = "Min value", value = "blue"),
        shiny::submitButton()
        ),
      # Specifies what to put in the main panel
      shiny::mainPanel(shiny::plotOutput("plot_output",width="900px",height="700px"))
      )
    )

  server <- function(input, output, session) {
    output$plot_output <- shiny::renderPlot({
      if (input$NumberBeers == 0) {
        beers_dat |>
          tidyr::pivot_longer(4:6, values_to = "Volume", names_to = "Purpose") |>
          dplyr::filter(year %in% input$Year[1]:input$Year[2],
                        Purpose %in% input$Column,
                        state != "total") |>
          dplyr::group_by(state, state_full) |>
          dplyr::summarise(Volume = sum(Volume, na.rm = T),
                           AVG = almost(Volume/1000, N = input$NumberBeers)) |>
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
        ggplot2::scale_fill_gradient2(high = input$Max, low = input$Min, midpoint = 6) +
        ggplot2::labs(title = paste("Beer production per state (%)" )) +

        ggplot2::theme_void() +
        ggplot2::theme(legend.position = "bottom")
    }
    else if (input$NumberBeers %in% 1:7) {
      beers_dat |>
        tidyr::pivot_longer(4:6, values_to = "Volume", names_to = "Purpose") |>
        dplyr::filter(year %in% input$Year[1]:input$Year[2],
                      Purpose %in% input$Column,
                      state != "total") |>
        dplyr::group_by(state, state_full) |>
        dplyr::summarise(Volume = sum(Volume, na.rm = T),
                         AVG = almost(Volume/1000, N = input$NumberBeers)) |>
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
        ggplot2::scale_fill_gradient2(high = input$Max, low = input$Min, midpoint = 6) +
        ggplot2::labs(title = paste("Beer production per state (%)" ),
                      subtitle = paste("However with a bit of uncertainty since you chose to make me drink", input$NumberBeers, "beers...")) +
        ggplot2::theme_void() +
        ggplot2::theme(legend.position = "bottom")
    }
    else if (input$NumberBeers %in%  8:10) {

      world_map %>%
        dplyr::mutate(USA = ifelse(region == "USA", "USA", "nonUSA"),
                      USA = factor(USA, levels = c("USA", "nonUSA")))%>%
        ggplot2::ggplot(aes(fill = USA, map_id = region)) +
        ggplot2::geom_map(map = world_map, col = "black") +
        ggplot2::expand_limits(x = world_map$long, y = world_map$lat) +
        ggplot2::coord_map("moll") +
        ggplot2::scale_fill_manual(values = c("#293F14", "#EDD3C4")) +
        ggplot2::labs(title = paste("I don't understand your question after", input$NumberBeers, "beers..."),
                      subtitle = "so I show you where the USA are...") +
        ggplot2::theme_void() +
        ggplot2::theme(legend.position = "none")

    }
    else {

      world_map %>%
        dplyr::mutate(USA = ifelse(region == sample(Region, 1), "USA", "nonUSA"),
                      USA = factor(USA, levels = c("USA", "nonUSA")))%>%
        ggplot2::ggplot(aes(fill = USA, map_id = region)) +
        ggplot2::geom_map(map = world_map, col = "black") +
        ggplot2::expand_limits(x = world_map$long, y = world_map$lat) +
        ggplot2::coord_map("moll") +
        ggplot2::scale_fill_manual(values = c("#293F14", "#EDD3C4")) +
        ggplot2::labs(title = paste("I don't understand your question after", input$NumberBeers, "beers..."),
                      subtitle = "so I show you a random country") +
        ggplot2::theme_void() +
        ggplot2::theme(legend.position = "none")
    }
  })



}
  shiny::shinyApp(ui = ui, server = server)
  # Update this function call
  utils::globalVariables(c("AVG", "AlmostPercent", "AlmostTotal", "Percent", "Purpose", "Total", "USA", "Volume", "region", "state", "state_full", "year"))
