#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)
library(leaflet)
library(shinyWidgets)


# Define server logic required to draw a histogram
function(input, output, session) {
  
  dcidIcon <- leaflet::icons(iconUrl = "dcidLogo.png",
                             iconWidth = 70,iconHeight = 40)
  
  dcidPopup <- paste0("<p><span style='font-size:120%; font-weight: bold'>Dcid Consulting</span></p>
                      <p><hr><br>Consultancy - Training - Expertise - Development<br>Data Science & Machine Learning & Data Analytics</br></p>
                      <p><a href='http://www.dcid-consulting.fr/' target='_blank'>You are welcome to visit my website !</a></p>")
  
  output$plot <- leaflet::renderLeaflet({
    leaflet::leaflet() %>%
      leaflet::addTiles(urlTemplate = "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga", attribution = "Map data ©2019 Google", group = "Google Map") %>%
      leaflet::addProviderTiles("OpenStreetMap.Mapnik", group = "OSM World Map") %>%
      leaflet::addProviderTiles("OpenStreetMap.France", group = "OSM France Map") %>%
      leaflet::addProviderTiles("Esri.WorldTopoMap", group = "ESRI World Topo Map") %>%
      leaflet::addProviderTiles("Esri.WorldImagery", group = "ESRI World Imagery") %>%
      leaflet::addLayersControl(
        baseGroups = c("Google Map", "OSM World Map", "OSM France Map", "ESRI World Topo Map", "ESRI World Imagery"),
        position = "topright",
        options = leaflet::layersControlOptions(collapsed = TRUE)
      ) %>%
      leaflet::addMarkers(lng = 1.9251055982239462, lat = 47.84702108657898, icon=dcidIcon,
                          popup = dcidPopup,
                          label = "Dcid Data Science Consulting") %>%
      # leaflet::setView(lng = 1.9251055982239462, lat = 47.84702108657898, zoom = 8) 
      leaflet::setView(lng = 1.9251055982239462, lat = 47.84702108657898, zoom = input$slider) %>%
      leaflet::addControl(layerId = "mapInfo", shinyWidgets::actionBttn(inputId = "mapBtnInfo", label = "Info", color = "danger", size = "xs", style = "jelly"), position="bottomright") %>%
      leaflet::addControl(HTML('<a href="http://www.dcid-consulting.fr/" target="_blank">Source : dcid-consulting.fr</a>'), position = "bottomleft", "map-title")
  })
  
  
  # Affichage d'une fenetre modal (information previsions) sur l'evenement clik bouton "mapInfo"
  observeEvent(input$mapBtnInfo, {
    showModal(modalDialog(
      title = "Information on map",
      div(h5("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
      ),
      footer = modalButton("OK"),
      easyClose = TRUE
    ))
  })

}

