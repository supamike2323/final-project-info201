library(shiny)
library(DT)
library(tidyverse)
library(stringr)
library(ggplot2)
library(plotly)
library(dplyr)
library(fmsb)

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
    if (input$soup == 1){
      
      return(make_radar_df(input$selects111)[3,])
    }
  })
  
  output$text1 <- renderText({
    paste0("Belonged NBA team: ", player_df[which(player_df$Player == input$selects111), 2])
  })
  
  output$radar <- renderPlot({
    radarchart(make_radar_df(input$selects111), axistype = 1,
               pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 ,
               cglcol="orange", cglty=1, axislabcol = "blue", cglwd=0.8, vlcex=0.8)
  })
  
  
  output$bar <- renderPlotly({
    filtered_team <- avg_age %>%
      filter(Team %in% input$team_select)
    
    filtered_team <- filtered_team %>%
      filter(mean <= input$range1)
    
    bar <- ggplot(data=filtered_team, aes(x=mean, y=Team, fill=Team)) +
      geom_bar(position="dodge", stat="identity") + ggtitle("Different NBA teams and their age mean") +
      xlab("Mean Age") + ylab("NBA Teams")
    
    bar <- ggplotly(bar)
    
    return(bar)
    
  })
  
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
