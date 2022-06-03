library(shiny)
library(dplyr)
library(ggplot2)
library(fmsb)

stat_df <- read.csv("C:/Users/15184/Desktop/final project/data.csv")

player_df <- stat_df %>%
  select(Player, Tm, TRB, AST, STL, BLK, TOV, PTS)

summary_page <- tabPanel(
  "Summary",
  titlePanel("Examning every single player's six major statistics in the NBA")
  
)

analysis_page <- tabPanel(
  "NBA player analysis",
  sidebarLayout(
    sidebarPanel(
      h3("Control Panel"),
      selectInput(
        inputId = "selects",
        label = "Select a Player",
        choices = player_df$Player
      ),
    ),
    mainPanel(
      plotOutput(outputId = 'radar'),
      tableOutput(outputId = "table")
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
  make_radar_df <- function(player_name){
    rd_df <- select(player_df, -c(Player, Tm))
    
    min_df <- summarise_all(rd_df, min)
    max_df <- summarise_all(rd_df, max)
    
    data_pt <- filter(player_df, Player == player_name)
    data_pt <- select(data_pt, -c (Player, Tm))
    
    do.call("rbind", list(max_df, min_df, data_pt))
  }
  
  output$table <- renderTable({
    return(make_radar_df(input$selects))
  })
  
  output$radar <- renderPlot({
    radarchart(make_radar_df(input$selects), axistype = 1,
               pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 ,
               cglcol="orange", cglty=1, axislabcol = "blue", cglwd=0.8, vlcex=0.8)
  })
}

#part that actually makes the shiny app
shinyApp(ui = ui, server = server)