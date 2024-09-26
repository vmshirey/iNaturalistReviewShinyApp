library(shiny)
library(shinydashboard)
library(shinythemes)
library(tidyverse)
library(DT)

iNat_dt <- data.table::fread("Cleaned_Master_Database_Vaughn.csv") %>%
  dplyr::select(Key, Language, `Publication Year`, Author, Title, Journal,
                `Study Area Country`, `Study Area Region`, `Study Area Continent`, 
                15:21, `Paper Topic`)

ui <- shinydashboard::dashboardPage(
  
  shinydashboard::dashboardHeader(title = "iNaturalist Review Papers"),
  shinydashboard::dashboardSidebar(width = 300, tags$p("\nWelcome to our Shiny app which will allow you to browse the papers included in our review of work that has utilized iNaturalist data.")),
  shinydashboard::dashboardBody(
    
    shiny::fluidRow(
      
      DT::dataTableOutput("mytable")
      
    )
  ), skin = "green"
)

server <- function(input, output){
  
  output$mytable <- DT::renderDataTable(iNat_dt,
                                        filter = "top", 
                                        options = list(pageLength = 10,
                                                       scrollX = TRUE,
                                                       scrollCollapse = TRUE))
  
}

shinyApp(ui = ui, server = server)