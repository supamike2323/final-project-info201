library(shiny)
library(DT)
library(tidyverse)
library(stringr)
library(ggplot2)
library(plotly)

data_df <- read.csv("https://raw.githubusercontent.com/supamike2323/final-project-info201/main/nba2021_per_game.csv")

age <- data_df %>%
  group_by(Tm) %>%
  summarise(Age)

age <- tapply(data_df$Age, data_df$Tm, mean)

avg_age <- data.frame(Team=names(age),mean=age)


#first page
first_page <- tabPanel(
  "Introduction",
  "IntroductionIntroductionIntroductionIntroductionIntroductionIntroductionIntroductionIntroductionIntroduction",
  h3("sadasadasadasadasadasadasadasadasadasadasadasadasadasada"),
  p("sadasadasadav")
)

page2_main <- mainPanel(
  h2("Chart"),
  plotlyOutput(outputId = "bar"),
  h2("Insight"),
  p("ww")
)

page2_sidebar <- sidebarPanel(
  selectInput(
    inputId = "team_select",
    label = "NBA Team",
    choices = avg_age$Team,
    multiple = TRUE,
    selected = "WAS"
  )
  
)

second_page <- tabPanel(
  "NBA Team Player Average Age Comparision",
  sidebarLayout(
    page2_sidebar,
    page2_main
  )
)

third_page <- tabPanel(
  "Second interactive chart page",
  titlePanel("Interactive chart between a and b"),
  sidebarLayout(
    sidebarPanel(
      h5("Controls"), 
      sliderInput(
        inputId = "yr_range",
        label = "Choose the year range:",
        min = 1750,
        max = 2020,
        value = 1949
      ),
      selectInput(
        inputId = "material",
        label = "Different Material that would cause CO2:",
        cho = c("gas", "coal", "oil"),
        selected = "coal"
      ),
    ),
    mainPanel(
      h3("The importance of this chart"),
    )
  )
)

fourth_page <- tabPanel(
  "Third interactive chart page",
  titlePanel("Interactive chart between a and b"),
  sidebarLayout(
    sidebarPanel(
      h5("Controls"), 
      sliderInput(
        inputId = "yr_range",
        label = "Choose the year range:",
        min = 1750,
        max = 2020,
        value = 1949
      ),
      selectInput(
        inputId = "material",
        label = "Different Material that would cause CO2:",
        cho = c("gas", "coal", "oil"),
        selected = "coal"
      ),
    ),
    mainPanel(
      h3("The importance of this chart"),
    )
  )
)

fifth_page <- tabPanel(
  "Summary takeaways",
  h3("Summary takeawaysSummary takeawaysSummary takeawaysSummary takeawaysSummary takeaways"),
  p("Summary takeawaysSummary takeawaysSummary takeawaysSummary takeawaysSummary takeawaysSummary takeaways")
)

ui <- navbarPage(
  "Final Project Analysis by Mike Deng, Yaqi Liu, Hana Geer, and Zijing Ding",
  first_page,         
  second_page,
  third_page, 
  fourth_page,
  fifth_page
)

server <- function(input, output){
}