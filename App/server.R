library(shiny)

swaps <- read.csv('swaps.csv')
data(mtcars)
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automatic", "Manual")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    mySwaps <- swaps[swaps$Riding1 == input$inRiding1 &
                       swaps$Party1 == input$inParty1, ]
    mySwaps <- mySwaps[with(mySwaps, order(-totalBenefit)), ]
    mySwaps <- subset(mySwaps, ! Party2 %in% input$inVetoParties)
    names <- gsub(" ", "\n", gsub(" –", "", mySwaps[1:10, ]$Riding2))
    partyColours <- c('#F78320','#263893','#D71921',
      '#3D9B35','#00A7EC', 'grey')
    names(partyColours) <- c('New Democratic', 'Conservative', 'Liberal',
      'Green', 'Bloc Quebecois', 'Other')
    colors <- sapply(mySwaps[1:10, "Party2"], function(x){partyColours[x]})
    op <- par(mar=c(11,4,4,2))
    barplot
    barplot(height = as.numeric(mySwaps[1:10,"Benefit1"]),
            names.arg = names, 
            horiz=F,
            las=2,
            ylab = "Your vote value factor",
            col=colors)
    rm(op)
  })
})
