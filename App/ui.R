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
                         choices = levels(swaps$Party2)),
      p("Party colour codes:"),
      p("Bloc Quebecois", style = "color:#00A7EC"),
      p("Conservative", style = "color:#263893"),
      p("Green", style = "color:#3D9B35"),
      p("Liberal", style = "color:#D71921"),
      p("NDP", style = "color:#F78320"),
      p("Other", style = "color:grey")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Recommendations",
          p("This app recommends strategic vote swaps based on current election forecasts."),
          p("Select your riding and your preferred party."),
          p("The app will recommend the best ridings to look for swap partners."),
          p("Find your riding at ", 
              a("Elections Canada", href="http://elections.ca/"),
            "."),
          plotOutput("distPlot"),
          p("Copy and paste your swap request to the ",
            a("Vote Swap Canada Facebook group", href="http://www.facebook.com/voteswapcanada"),
            ":"),
          textOutput("requestText")
        ),
        tabPanel("What is this?",
                 p("The recommendations provided by this site are based on the strategic value of Canadians' votes."),
                 p("The ten most strategically important swaps for your preferred party in your riding are shown in decending order of importance from left to right. The height of the bars in the plot represent how many times more valuable your vote would be in terms of contributing to a seat in parliament for your preferred party if you vote swapped. Each bar has a colour indicating the party that your vote swap partner supports (i.e. the party that you would physically vote for if you arranged the swap)."),
                 p("This analysis assumes that the value of a vote is inversely proportional to the number of votes separating your preferred party and the leader in your riding, or their closest competition if they are the leader, according to current elections forecasts."),
                 p("The election forecasts are provided by ",
                    a("threehundredeight.com", href="http://www.threehundredeight.com")),
                 p("More details of this analysis can be found on ", 
                   a("my blog.", 
                     href="https://rwuncertainty.wordpress.com/2015/10/04/canadas-voter-inequality-and-the-vote-swapping-economy/")),
                 p("Analysis details and source code are available on ",
                   a("my Github. ", href="http://www.github.com/QEDan"), "Pull requests are welcome."),
                 p("This software is released under an MIT free software licence. Copyright ",
                   a("Dan Mazur ", href="http://www.danmazur.ca"),
                  "2015.")
                 )
      )
    )
  )
))
