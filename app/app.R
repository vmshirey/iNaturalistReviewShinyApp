library(shiny)
library(shinydashboard)
library(shinythemes)
library(dplyr)
library(readr)
library(DT)

iNat_dt <- read_csv("Cleaned_Master_Database_Vaughn.csv",
                    locale = locale(encoding = "Latin1")) %>%
  dplyr::select(Key, Language, `Publication Year`, Author, Title, Journal,
                `Study Area Country`, `Study Area Region`, `Study Area Continent`, `Studied Taxa - Order`,
                `Species of Conservation Concern?`, `Non-Native Species?`, `iNaturalist Data Type`,
                15:20, `Paper Topic`, `Analyses Conducted`)

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
                                        options = list(pageLength = 5,
                                                       scrollX = TRUE,
                                                       scrollCollapse = TRUE))
  
}

shinyApp(ui = ui, server = server)