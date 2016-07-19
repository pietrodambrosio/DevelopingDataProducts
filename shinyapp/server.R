library(shiny)
library(rgeos)
library(maptools)
library(ggplot2)



codreg = 1
voice = "1100"
voice2 = voice



allregions <- read.csv("data/regions.csv")
cashdata <- read.csv("data/SIOPE_cassa.csv")
voices <- read.csv("data/VociSiope.csv",sep=";")

mreg <- readShapeSpatial("data/Reg2014_ED50g/Reg2014_ED50_g.shp")


theme_bare <- theme(
    axis.line = element_blank(), 
    axis.text.x = element_blank(), 
    axis.text.y = element_blank(),
    axis.ticks = element_blank(), 
    axis.title.x = element_blank(), 
    axis.title.y = element_blank(), 
    #axis.ticks.length = unit(0, "lines"), # Error 
    #axis.ticks.margin = unit(c(0,0,0,0), "lines"), 
    legend.position = "none", 
    panel.background = element_rect(fill = "white"), 
    panel.border = element_blank(), 
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    panel.margin = unit(c(0,0,0,0), "lines"), 
    plot.background = element_rect(fill = "white"),
    plot.margin = unit(c(0.2,0,0,0), "lines")
)



# Shiny server 
shinyServer(function(input, output, session) {
    
    # Create event type radiobuttons
    output$regions <- renderUI({
        radioButtons('reg', label = "Italian Regions", choices = as.character(allregions$Region) )
    })
    
    output$voicedesc <- renderText({
        desc = as.character( voices[voices$CodVoce == input$voice,2])
#        paste("VOCE = ",input$voice,desc)
    })
    
    output$regdesc <- renderText({
        desc = paste("Region:",input$reg)
    })

    output$valitaly <- renderText({
        val <- as.numeric(cashdata[cashdata$Area == "ITA" & cashdata$Ind == input$voice2 & cashdata$Anno == "2016" & cashdata$Mese == 5,6])
        val <- format(round(val,2),big.mark=",",decimal.mark=".",digits=15)
        desc = paste("Current Value for Italy (May 2016):",val)
    })
    
    output$mitaly <- renderPlot({
        wdf <- cashdata[cashdata$Area == "REG" & cashdata$Ind == input$voice2 & cashdata$Anno == "2016" & cashdata$Mese == 5,]
        c <- wdf$Cod
        t<-wdf$Val
        dfc<-data.frame(c,t)
        names(dfc)<-c("COD_REG","VAL")
        mreg_f <- fortify(mreg, region = "COD_REG")
    
        g<-ggplot() + geom_map(data = dfc,aes(map_id = COD_REG,fill = as.numeric(VAL)),
                               map = mreg_f,color = 'white') + 
            expand_limits(x = mreg_f$long, y = mreg_f$lat) + coord_equal()+
            scale_fill_gradient(name = "%Cash Value", low="#C4FF88", high="#60A010")+
            theme_bare
        
            
        print(g)
        
        
        
        
    })
    
    output$p_trend <- renderPlot({
        codreg = allregions[allregions$Region == input$reg,1]
        wdf <- cashdata[cashdata$Area == "REG" & cashdata$Cod == codreg & cashdata$Ind == input$voice & cashdata$Anno >= input$Years[1] & cashdata$Anno <= input$Years[2],]
        valts <- ts(wdf$Val, frequency=12)
        decom <- decompose(valts)
        plot(cbind(observed = decom$random +
            decom$trend * decom$seasonal, trend = decom$trend, seasonal = decom$seasonal,
            random = decom$random), main = "",yaxt="n")
#        plot.ts(valts)
    })
    

})


