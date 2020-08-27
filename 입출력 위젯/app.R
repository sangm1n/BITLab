#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(broom)

# Define UI for application that draws a histogram
ui <- fluidPage(
    h2(textOutput("title")),
    h3(textOutput("text")),
    textInput("textEx", "input text:"),
    verbatimTextOutput("txt"),
    passwordInput("textEx2", "input password:"),
    
    h3(textOutput("num")),
    sliderInput("numEx", "slider:",
                min=0, max=50000, value=10000, step=1000,
                pre="￦", sep=",", animate=animationOptions(
                    interval=500, loop=TRUE
                )),
    sliderInput("numEx2", "date:",
                min=as.Date("2020-08-10"), max=as.Date("2020-08-31"),
                value=c(as.Date("2020-08-19"), as.Date("2020-08-23"))),
    
    h3(textOutput("sel")),
    selectInput("selEx", "selection:",
                choices=list("컴파일 언어" = c("C++", "Java"),
                             "스크립트 언어" = c("R", "Python"))),
    radioButtons("selEx2", "radio button:",
                 c("Normal" = "norm", "Uniform" = "unif",
                   "Log-normal" = "lnorm", "Exponential" = "exp")),
    plotOutput("hist"),
    checkboxGroupInput("selEx3", "check box:",
                       c("Red", "Blue", "Green", "Yellow", "Black")),
    
    h3(textOutput("btn")),
    actionButton("goBtn", "Go !"),
    
    h3(textOutput("table")),
    tableOutput("tab"),
    
    h3(textOutput("plot")),
    plotOutput("plotEx"),
    
    h3(textOutput("image")),
    fluidRow(
        column(3,
               img(src="R_logo.png", width="100%")),
        column(9,
               sliderInput("rand", "No. of random numbers",
                           30, 100, 50, width="100%"),
               plotOutput("myPlot", width="100%"))
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    output$title <- renderText({"Input/Output widget examples"})
    output$text <- renderText({"1. Text"})
    output$txt <- renderPrint({
        req(input$textEx)
        input$textEx
    })
    
    output$num <- renderText({"2. Number"})
    
    output$sel <- renderText({"3. Selection"})
    output$hist <- renderPlot({
        selEx2 <- switch(input$selEx2, norm=rnorm, unif=runif,
                         lnorm=rlnorm, exp=rexp, rnorm)
        hist(selEx2(500))
    })
    
    output$btn <- renderText({"4. Button"})
    
    output$table <- renderText({"5. Table"})
    output$tab <- renderTable({
        tidy(lm(mpg~wt+qsec, data=mtcars))
    }, striped=TRUE, hover=TRUE, bordered=TRUE)
    
    output$plot <- renderText({"6. Plot"})
    output$plotEx <- renderPlot({
        plot(mtcars$wt, mtcars$mpg)
    })
    
    output$image <- renderText({"7. Image"})
    output$myPlot <- renderPlot({
        hist(rnorm(input$rand))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
