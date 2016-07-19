
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:

library(shiny)


shinyUI(
    navbarPage("Bank Of Italy SIOPE database - Cash availability by Region",
        tabPanel("Trends",
                sidebarPanel(
                    sliderInput("Years",
                        "Years range", 
                        min = 2008, 
                        max = 2016, 
                        value = c(2008,2016),
                        sep = ""),
                    selectInput("voice", "Accounting voice:",
                                c("Cash Fund (beginning of year)" = "1100",
                                  "Charges made in the month" = "1200",
                                  "Payments made in the month" = "1300",
                                  "Chash fund at end of the month" = "1400")),
                    uiOutput("regions"),
                    width = 4
                ),
  
                mainPanel(
                    h3(textOutput("voicedesc"), align = "center"),
                    h4(textOutput("regdesc"), align = "center"),
                    plotOutput("p_trend")

                )

        ),
        
        tabPanel("Current",
            mainPanel(
                h3(selectInput("voice2", NULL,
                            c("Cash Fund (beginning of year)" = "1100",
                              "Charges made in the month" = "1200",
                              "Payments made in the month" = "1300",
                              "Chash fund at end of the month" = "1400"),width = '100%'), align="center"),
                h4(textOutput("valitaly"), align="center"),

                # plot map of italy
                plotOutput("mitaly"),
                
                width = 12)
        ),        
    
        tabPanel("About",
             mainPanel(
                 h1("About"),
                 p("This application is based on the Bank of Italy SIOPE data base. "),
                 p("SIOPE is an Information System that collect all economical and financial operations of Italian public offices."),
                 p("The SIOPE system is managed by the Bank of Italy, Istat and Italian General Accounting Office  and is an electronic detection system of receipts and payments made by local government offices."),
                 p("In this application we show you some SIOPE data on the cash availability of italian municipalities, grouped by region."),
                 p("In particular the 'TREND' page shows periodic trends in 4 different accounting entries. Instead the 'CURRENT' page displays on a choropleth map the cash situation referred to May 2016."),
                 h3("To Use Application"),
                 p("In 'Trend' page select years range, accounting voice and region; the application will show you the decomposed time series plot of data selected."),
                 p("In 'Current' page select accounting voice; the application will show you the current total value of selected voice and a choropleth map of italian region."),
                 width = 12
             )
        ) 
    )
)
