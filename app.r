library(shiny)
library(dplyr)
library(ggplot2)
library(fmsb)

nbastats_df <- read.csv("C:/Users/15184/Desktop/final project/data.csv")

stats_df <- nbastats_df %>%
  select(Player, PTS, Tm)

summary_page <- tabPanel(
  "Summary",
  titlePanel("This application will demonstrate the scoring statistics of all NBA players
              in different teams"),
  p("This viz lets you explore the various team players")
  
)

analysis_page <- tabPanel(
  "Player's scoring statistics in different teams",
  sidebarLayout(
    sidebarPanel(
      h3("Control Panel"),
      selectInput(
        inputId = "selects",
        label = "Select a team",
        choices = stats_df$Tm
      ),
      sliderInput("range", "Scoring range:",
                  min = 1, max = 40,
                  value = 1),
    ),
    mainPanel(
      plotOutput(outputId = 'Plot')
    )
  )
)

ui <- navbarPage(
  "Player statistic analysis",
  summary_page,
  analysis_page
)

# Define server logic ---
server <- function(input, output){
  output$Plot <- renderPlot({
    hist(rnorm(input$range))
    tm_data <- stats_df %>%
      filter(Tm %in% input$selects, PTS <= input$range)
    ggplot(data=tm_data,aes(x=reorder(Player,PTS),y=PTS)) + 
      geom_bar(stat ='identity',aes(fill=PTS))+
      coord_flip() + 
      theme_grey() + 
      scale_fill_gradient(name="Points Per Game")+
      labs(title = 'Ranking of Points per games',
           y='Points Per Game',x='Players')+ 
      geom_hline(yintercept = mean(stats_df$PTS),size = 1, color = 'orange')
  })
}

#part that actually makes the shiny app
shinyApp(ui = ui, server = server)