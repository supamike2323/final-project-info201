library(shiny)
library(DT)
library(tidyverse)
library(stringr)
library(ggplot2)
library(plotly)
library(dplyr)
library(fmsb)

data_df <- read.csv("https://raw.githubusercontent.com/supamike2323/final-project-info201/main/nba2021_per_game.csv")
data_df$Tm <- gsub('ATL', 'Atlanta Hawks', data_df$Tm)
data_df$Tm <- gsub('BOS', 'Boston Celtics', data_df$Tm)
data_df$Tm <- gsub('BRK', 'Brooklyn Nets', data_df$Tm)
data_df$Tm <- gsub('CHI', 'Chigaco Bulls', data_df$Tm)
data_df$Tm <- gsub('CHO', 'The Charlotte Hornets', data_df$Tm)
data_df$Tm <- gsub('CLE', 'Cleveland Cavaliers', data_df$Tm)
data_df$Tm <- gsub('DAL', 'Dallas Mavericks', data_df$Tm)
data_df$Tm <- gsub('DEN', 'Denver Nuggets', data_df$Tm)
data_df$Tm <- gsub('DET', 'Detroit Pistons', data_df$Tm)
data_df$Tm <- gsub('GSW', 'Golden States Warriors', data_df$Tm)
data_df$Tm <- gsub('HOU', 'Houston Rockets', data_df$Tm)
data_df$Tm <- gsub('IND', 'Indiana Pacers', data_df$Tm)
data_df$Tm <- gsub('LAC', 'Los Angeles Clippers', data_df$Tm)
data_df$Tm <- gsub('MEM', 'Memphis Grizzlies', data_df$Tm)
data_df$Tm <- gsub('MIA', 'Miami Heats', data_df$Tm)
data_df$Tm <- gsub('MIL', 'Milwaukee Bucks', data_df$Tm)
data_df$Tm <- gsub('MIN', 'Minnesota Timberwolves', data_df$Tm)
data_df$Tm <- gsub('NOP', 'New Orleans Pelicans', data_df$Tm)
data_df$Tm <- gsub('NYK', 'New York Knicks', data_df$Tm)
data_df$Tm <- gsub('OKC', 'Oklahoma City Thunder', data_df$Tm)
data_df$Tm <- gsub('ORL', 'Orlando Magic', data_df$Tm)
data_df$Tm <- gsub('PHI', 'Philadelphia 76ers', data_df$Tm)
data_df$Tm <- gsub('PHO', 'Phoenix Suns', data_df$Tm)
data_df$Tm <- gsub('POR', 'Portland Trail Blazers', data_df$Tm)
data_df$Tm <- gsub('SAC', 'Sacramento Kings', data_df$Tm)
data_df$Tm <- gsub('SAS', 'San Antonio Spurs', data_df$Tm)
data_df$Tm <- gsub('TOR', 'Toronto Raptors', data_df$Tm)
data_df$Tm <- gsub('TOT', 'Two Other Teams', data_df$Tm)
data_df$Tm <- gsub('UTA', 'Utah Jazz', data_df$Tm)
data_df$Tm <- gsub('WAS', 'Washington Wizards', data_df$Tm)
data_df$Tm <- gsub('LAL', 'Los Angeles Lakers', data_df$Tm)

stats_df <- data_df %>%
  select(Player, PTS, Tm)

age <- data_df %>%
  group_by(Tm) %>%
  summarise(Age)

age <- tapply(data_df$Age, data_df$Tm, mean)

avg_age <- data.frame(Team=names(age),mean=age)

stats_df <- data_df %>%
  select(Player, PTS, Tm)

player_df <- data_df %>% arrange(Player) %>%
  select(Player, Tm, TRB, AST, STL, BLK, TOV, PTS)

names(player_df)[names(player_df) == "TRB"] <- "Rebounds per game"
names(player_df)[names(player_df) == "AST"] <- "Assists per game"
names(player_df)[names(player_df) == "STL"] <- "Steals per game"
names(player_df)[names(player_df) == "BLK"] <- "Blocks per game"
names(player_df)[names(player_df) == "TOV"] <- "Turn Overs per game"
names(player_df)[names(player_df) == "PTS"] <- "Points per game"