#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(DT)
library(tidyverse)
library(stringr)
library(ggplot2)
library(plotly)
library(dplyr)
library(fmsb)
source("data_frames.R")
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
