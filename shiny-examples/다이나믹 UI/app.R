#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(stringr)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("diamonds data"),

    selectInput(
        "plotType", "Plot Type",
        c(Scatter="scatter",
          Histogram="hist"),
    ),
    
    conditionalPanel(
        condition="input.plotType=='hist'",
        selectInput(
            "breaks", "Breaks",
            c("Sturges", "Scott", "Freedman-Diaconis", "[Custom]"="custom")
        )
    ),
    
    conditionalPanel(
        condition="input.plotType=='scatter'",
        sliderInput("breakCount", "Break Count",
                    min=1, max=1000, value=10)
    ),
    
    plotOutput("plot"),
    
    titlePanel("renderUI() / uiOutput()"),
    uiOutput("moreControls"),
    
    titlePanel("Choose the table or plot"),
    radioButtons("selected", label="choose",
                 choices=list("table", "plot")),
    uiOutput("table2"),
    uiOutput("plot2"),
    
    titlePanel("insertUI() / removeUI()"),
    actionButton("add", "Add UI"),
    actionButton("remove", "Remove UI"),
    textInput("txt", "This is no longer useful"),
    
    actionButton("add2", "Add UI"),
    verbatimTextOutput("allText"),
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    brs <- reactive({
        if (input$breaks=="custom") {
            input$breakCount
        } else {
            input$breaks
        }
    })
    
    p <- reactive({
        if (input$plotType=="scatter") {
            plot(diamonds$carat, diamonds$price, col="red")
        } else {
            hist(diamonds$carat, breaks=brs())
        }
    })
    
    output$plot <- renderPlot({
        p()
    })
    
    output$moreControls <- renderUI({
        tagList(
            sliderInput("n", "N", 1, 1000, 500),
            textInput("label", "Label")
        )
    })
    
    output$table1 <- renderTable({
        mtcars
    })
    
    output$table2 <- renderUI({
        if (input$selected=="table") {
            tableOutput("table1")
        }
    })
    
    output$plot1 <- renderPlot({
        plot(mtcars$wt, mtcars$mpg, col="blue")
    })
    
    output$plot2 <- renderUI({
        if (input$selected=="plot") {
            plotOutput("plot1")
        }
    })
    
    observeEvent(input$add, {
        insertUI(
            selector="#add",
            where="afterEnd",
            ui=textInput(paste0("txt", input$add),
                         "Insert some text")
        )
    })
    
    observeEvent(input$remove, {
        removeUI(
            selector="div:has(> #txt)"
        )
    })
    
    observeEvent(input$add2, {
        insertUI(
            selector="#add2",
            where="afterEnd",
            ui=textInput(paste0("txt", input$add2),
                         "Insert some text", placeholder="input strings")
        )
    })
    
    output$allText <- renderPrint({
        req(input$add2)
        txts <- unlist(lapply(seq(1, input$add2), function(x) paste0("txt", x)))
        paste(unlist(lapply(txts, function(x) str_trim(input[[x]]))), 
                     collapse=" ")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
