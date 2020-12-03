#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Leaflet is awesome"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(

    sidebarPanel(
      sliderInput("slider", label="Zoom for map", min=1, max=20, value=8)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      leaflet::leafletOutput("plot", height = "600px", width = "100%")
    )
  )
)
