library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")

data_df <- read.csv("https://raw.githubusercontent.com/supamike2323/final-project-info201/main/nba2021_per_game.csv")

age <- data_df %>%
  group_by(Tm) %>%
  summarise(Age)

age <- tapply(data_df$Age, data_df$Tm, mean)

avg_age <- data.frame(Team=names(age),mean=age)


################################################################################

server <- function(input, output){
  
  output$bar <- renderPlotly({
    filtered_team <- avg_age %>%
      filter(Team %in% input$team_select)
    
    bar <- ggplot(data=filtered_team, aes(x=mean, y=Team, fill=Team)) +
      geom_bar(position="dodge", stat="identity")
    
    bar <- ggplotly(bar)
    
    return(bar)
    
  })

  
}
