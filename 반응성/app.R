#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    titlePanel("Calculation app"),
    wellPanel(p("choose two numbers and symbol")),
    textInput("first", "first number:"),
    textInput("second", "second number:"),
    radioButtons("radio", "choose symbol:",
                 choices=c(
                     "+" = "add",
                     "-" = "minus",
                     "*" = "multi",
                     "/" = "divide"
                 ), inline=TRUE),
    h3("Result"),
    textOutput("result"),
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    outputText <- reactive({
        req(input$first, input$second)
        num1 <- as.numeric(input$first)
        num2 <- as.numeric(input$second)
        switch(input$radio,
               "add" = {
                   paste(num1, "+", num2, "=", num1+num2)
               },
               "minus" = {
                   paste(num1, "-", num2, "=", num1-num2)
               },
               "multi" = {
                   paste(num1, "*", num2, "=", num1*num2)
               },
               "divide" = {
                   paste(num1, "/", num2, "=", num1/num2)
               })
    })
    
    output$result <- renderText({
        outputText()
    })
    
    observe({
        cat(outputText(), "\n")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
