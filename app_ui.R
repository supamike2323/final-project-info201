library(shiny)
library(DT)
library(tidyverse)
library(stringr)
library(ggplot2)
library(plotly)
library(dplyr)
library(fmsb)

#first page
first_page <- tabPanel(
  "Introduction",
  h3("Introduction"),
  p("We are interested in this field because we share a common interest, which is sports. Some of us like basketball, and some of us like volleyball, so we just flipped a coin to decide which sport data set should we do, and the basketball side won. We think that doing an data analysis on the 2021-2022 season NBA data of players would be interesting because there is a playoff going on in NBA, and having the data for the players in different teams can help us understand who will eventually win the championship for this year, and also a deeper understanding of the data of NBA. We have also found similar project regarding to this data set, including but not limited to: “Using Machine Learning to Profile 2020 NBA Draft Prospects”, “DATA-DRIVEN APPROACHES TO NBA TEAM EVALUATION AND BUILDING”, and “Model that can predict whether a basketball shot attempt will be a miss.” By doing this analysis, we aim for a deeper understanding of using R and hopefully we can answer these 3 questions below:"),
  br(),
  h4("Would age affect the performance of a NBA player?"),
  h4("Would the dominant NBA stars significantly affect the overall performace of their teams?"),
  h4("How can we better visualize the performance of an individual player? \n"),
  br(),
  h3("Analysing the dataset"),
  br(),
  tags$a(href="https://www.kaggle.com/datasets/a431e6fbff68669f62ed8fe885478db6169377f24bd818a25a3e8f52ada615c7?resource=download&select=nba2021_per_game.csv", 
         "This is the link to our dataset"),
  p("We will be using the dataset found on Kaggle, this dataset is called \"Nba 2020-2021 Season Player Stats\" by UMUT ALPAYDIN in 2021. There are 3 files provided, one about the overall stats of the player, we did not choose this one because it was too big and it was hard to manipulate such an enormous dataset, the other one was about the dataset of the 36 minutes of every game, which we deemed as too small. Eventually, we chose the nba2021_per_game.csv in this dataset, which has the right amount of dataset and we could understand it thoroughly. By analyzing this dataset, we have created three different reactive charts to answer those questions above. Feel free to click on the buttons above to inspect them individually to see what we made. Below is an image of our group's favorite player, Kobe Bryant, who died in a helicopter crash. And we all recognized him as one of the best players in the entire history of basketball. R.I.P. Kobe. "),
  img(src = "JYhPlZ.png", height = 400, width = 300)
  )
#second page
page2_main <- mainPanel(
  h2("Average ages in every NBA team in the NBA season of 2020 - 2021"),
  plotlyOutput(outputId = "bar"),
  h2("Insights"),
  p(paste0("By observing this chart and using it multiple times, we think that the question: 
           \"Would age affect the performance of an NBA player?\" can be answered. Doing some 
           background computing, the max mean age is ", max(avg_age[, 2]), ", and the min means
           age is ", min(avg_age[, 2]), " . By selecting some of the most dominant NBA teams, th
           e Milwaukee Bucks (20 - 21 NBA team Champion), Phoenix Suns (Western Conference champion), 
           Atlanta Hawks (Conference Finals), LA Clippers (Conference Finals), Philadelphia 76ers 
           (Conference Semifinals), Utah Jazz (Conference Semifinals). This is the chart generated below:")),
  img(src = "Chart1.png", height = 500, width = 900),
  p("We can see that the mean age range is between 25.709 and 27.8667 (this is found by hovering the mouse on the bars), and the difference is pretty dramatic. Therefore, we can reasonable evidence to believe that age is not a crucial factor in the performance of the team, rather there are other potential factors that would affect performance.")
  )

page2_sidebar <- sidebarPanel(
  selectInput(
    inputId = "team_select",
    label = "NBA Team",
    choices = avg_age$Team,
    multiple = TRUE,
    selected = "WAS"
  ),
  sliderInput("range1", "Mean Age:",
              min = 23, max = 28.5,
              value = 26, step = 0.1),
  h4("How to use this reactive chart"),
  p("You can select teams and the chart would automatically generate the according to the mean age on it. You can find more details by hovering the mouse on the bar. The slider can filter out the max-age inputted and any team mean age above would be disregarded. ")
)

second_page <- tabPanel(
  "NBA Team Player Average Age Comparision in the NBA season of 2020 - 2021",
  sidebarLayout(
    page2_sidebar,
    page2_main
  )
)


#third page
stats_df <- data_df %>%
  select(Player, PTS, Tm)

third_page <- tabPanel(
  "Player's scoring statistics in different teams in the NBA season of 2020 - 2021",
  titlePanel("Demonstration the scoring statistics of all NBA players
              in different teams"),
  h3("This chart lets you explore the ranking of the team's player's points per game"),
  sidebarLayout(
    sidebarPanel(
      h3("Control Panel"),
      selectInput(
        inputId = "selects",
        label = "Select a team",
        choices = stats_df$Tm,
        selected = "Los Angeles Clippers"
      ),
      sliderInput("range", "Scoring range:",
                  min = 1, max = 40,
                  value = 30),
      h4("How to use this reactive chart"),
      p("Choosing the team and the chart will output the points per game of every single player in the team, and you can select the scoring range of the team so that you can filter out some player with detail. The yellow line is the mean of the player's points per game."),
    ),
    mainPanel(
      plotOutput(outputId = 'Plot'),
      h4("Analysis"),
      p("By observing this chart and playing with it multiple times. The question Would the dominant NBA stars significantly affect the overall performance of their teams? can be answered. We can easily find out that there is one or two key star player in the team that has extremely high points per game. Those are called the key star players in the team. LeBron James, Giannis Antetokounmpo, are cases in point. However, because we can find this fact in every single NBA team, one can claim that the dominant NBA stars do not affect the overall performance of their team significantly, and the performance of the team can affect not only by this factor but by other factors as well. From our perspective, we think that the overall chemistry of the key players and the side players is the crucial factor that leads to victory. The key star players would widen the gap between themselves and the opponents and the bench players would make sure this gap would not be reduced. ")
    )
  )
)

#fourth page
fourth_page <- tabPanel(
  "NBA Player's six major statistics in the NBA season of 2020 - 2021",
  titlePanel("Examining every single player's six major statistics in the NBA season of 2020 - 2021"),
  sidebarLayout(
    sidebarPanel(
      h3("Control Panel"),
      selectInput(
        inputId = "selects111",
        label = "Select a Player",
        choices = player_df$Player
      ),
      textOutput(outputId = 'text1'),
      radioButtons(
        inputId = "soup",
        label = "Would you like to see its stats?",
        choices = list("yes" = 1, "no" = 2),
        selected = 1
      ),
      h4("How to use this reactive chart"),
      p("You can select any NBA player in the 2020 - 2021 NBA season, and the radar chart of 6 important factors would be outputted, you can also choose the specific numbers or just the chart for better visualization.")
    ),
    mainPanel(
      plotOutput(outputId = 'radar'),
      tableOutput(outputId = "table"),
      h4("Analysis"),
      p("By observing this chart and playing with it multiple times. The question \"how can we better visualize the performance of an individual player?\" can be answered. People who love basketball sometimes would ask the question who is the best player in a season, and people have their own picks and explanation for that, and so does our team. Therefore, we wanted to have a better way of visualizing which player plays better in a single season. And that's why we have this reactive chart ready to use. It is a radar chart that analyses some of the 6 most crucial aspects of a player in our opinion. Assists, points, rebounds, steals, blocks, and turnovers. Therefore, we can figure out the fact that the more green in the radar chart, the better the player is. I also found some of the good players by this standard: Stephen Curry, LeBron James, Nikola Jokic, Luka Doncic, Giannis Antetokounmpo. This chart is by far the favorite chart we think as it is extremely helpful for data visualization.  "),
    )
  )
)

fifth_page <- tabPanel(
  "Summary takeaways",
  h3("Overall, there are 4 takeaways that we concluded overall."),
  h4("Crucial factors that contributes to the victory of NBA team"),
  p("After almost finishing up the project, we have not found the most significant factor that would determine the overall performance of the team. This might be disappointing, but we have all realized one thing in our final group meeting: What if there are none of the most significant factors overall? This is more reasonable to us since we have both rejected age and points as our key factors. We think that there are a lot of small factors that would affect the overall performance of the team. Those small factors include but are not limited to age, points per game, personal performance, coach, etc. This can further be proven in the real life in which the NBA championship is being got by different NBA teams each year starting in 2018. There are so many small factors that would contribute to winning/losing a single NBA match. And based on the skill we have now, it would be difficult to actually devise a meaningful key factor based on evidence. Therefore, we think that there is no most significant factor in NBA, but many small factors."),
  h4("Project Teamwork"),
  p("We all have had bad experiences working with others, even if we did not coordinate well and were submitting exploratory data analysis 5 minutes before it was due. However, this project has made all of us realize how important teamwork is in working with big projects. We used to think that \"oh I can do this on my own with ease\", however, we have had major stepbacks in this project and we were almost stuck in a single issue for a day. However, because of our teamwork, we collaborated and finally figured the solution out and continued working on it.  We appreciate and value each member's work and eventually, things get done faster and more efficient in teamwork.  "),
  h4("Working with coding project is fun"),
  p("This is the first time most of us know and use code to finish assignments. We think that this experience is new and worth memorable as this is something we have never tried before. Little did we know that we are actually developing website projects in less than 3 month and we are all pround of it. We are all starting to be in love with coding and would love to code in the future. "),
  h4("Time management is important"),
  p("For making this project, our team also created a brand new google calendar just to keep track of the assignments which you can see in the image below. This also shows the teamwork that we have in working on this project. By following this plan on the calendar, we all knew what we were working with and when is it due. By dividing a big project into smaller parts, we can allocate time for each small piece and eventually finish the project."),
  img(src = "Cal1.png", height = 500, width = 1100),
  h3("Thank you for visiting our project!!!")
)

ui <- navbarPage(
  theme = "custom.css",
  
  "Final Project Analysis by Mike Deng, Yaqi Lu, Hana Geer, and Zijing Ding",
  first_page,         
  second_page,
  third_page,
  fourth_page,
  fifth_page
)