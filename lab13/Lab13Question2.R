library("tidyverse")
library("shiny")
library("shinydashboard")
library("ggsci")
library("ggplot2")
library("gridExtra")



UC_admit <- readr::read_csv("data/UC_admit.csv")
UC_admit$Academic_Yr <- as.factor(UC_admit$Academic_Yr)



ui <- dashboardPage(
  dashboardHeader(title = "University of California"),
  dashboardSidebar(),
  dashboardBody(
    selectInput("y", "Select Filter", choices = c("Academic_Yr", "Campus", "Category"), selected = "Academic_Yr"),
    plotOutput("plot", width = "500px", height = "400px"))
)

server <- function(input, output, session) { 
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(Ethnicity!="All") %>% 
      ggplot(aes_string(x = "Ethnicity", y = "FilteredCountFR", fill=input$y)) +
      geom_col(position="dodge", alpha = 0.8, size=4)+
      theme_light(base_size = 18) + 
      labs(title= "University of California Admissions Data", x="Ethnicity", y="Number Admitted", fill = "Legend")+
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)

