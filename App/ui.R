library(shiny)
swaps <- read.csv('swaps.csv')


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Vote Swap Canada 2015"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "inRiding1",
                  label = "Select your riding",
                  choices = levels(swaps$Riding1)),
      selectInput(inputId = "inParty1",
                  label = "Select your preferred party",
                  choices = levels(swaps$Party1)),
      checkboxGroupInput(inputId = "inVetoParties",
                         label = "Parties you do *not* want to vote for",
                         choices = levels(swaps$Party2))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      p("This app recommends strategic vote swaps based on current election forecasts."),
      p("\n"),
      p("Select your riding and your preferred party."),
      p("\n"),
      p("The app will recommend the best ridings to look for swap partners."),
      plotOutput("distPlot")
    )
  )
))
