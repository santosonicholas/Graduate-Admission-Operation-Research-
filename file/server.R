source("data.R")


shinyServer(
  function(input, output){
    
    
    #header
    output$subHead <- renderText({
      paste("GRADUATE ADMISSION FOR MR./MRS. ",input$name)
    })
    
    
    
    #user summary score
    summaryValues <- reactive({
      data.frame(
        Name = c("GRE",
                 "TOEFL",
                 "University Rating",
                 "SOP",
                 "LOR",
                 "CGPA",
                 "Research",
                 "Chance of Admit"),
        Value = as.character(c(input$gre,
                               input$toefl,
                               input$univRat,
                               input$sop,
                               input$lor,
                               input$cgpa,
                               input$research,
                               input$chanceAdmit)),
        stringsAsFactors = FALSE)
      
    })
    
    
    
    ##user summary score
    output$summaryValues <- renderTable({
      summaryValues()
    })
    
    
    
    #Minimum values for graduate
    minimumValues <- reactive({
      data.frame(
        Name = c("GRE",
                 "TOEFL",
                 "CGPA",
                 "SOP",
                 "LOR"
                 ),
        Value = as.character(c(305,
                               87,
                               7.0,
                               2,
                               2
                               )),
        stringsAsFactors = FALSE)
      
    })
    
    
    
    #Minimum values for graduate
    output$minimumValues <- renderTable({
      minimumValues()
    })
    
    
    
    #barChart Plot topics
    output$plotChart <-renderPlot({
      plotType <- input$plot
      
      if(plotType =="GRE"){
        p1 <- c(305, input$gre)
        #par(xpd=T, mar=par()$mar+c(0,0,0,4))
        barplot(as.matrix(p1), main="GRE", ylab= "Score",
                space=0.1, cex.axis=0.8, las=1,names.arg=c("Minimum Score","Your Score"),
                cex=0.8,col=c("red","green"),beside=TRUE
        )
      }
      
      else if (plotType =="TOEFL"){
        p1 <- c(87, input$toefl)
        #par(xpd=T, mar=par()$mar+c(0,0,0,4))
        barplot(as.matrix(p1), main="TOEFL", ylab= "Score",
                space=0.1, cex.axis=0.8, las=1,names.arg=c("Minimum Score","Your Score"),
                cex=0.8,col=c("red","green"),beside=TRUE
        )
      }
      
      else if (plotType =="SOP"){
        p1 <- c(2, input$sop)
        #par(xpd=T, mar=par()$mar+c(0,0,0,4))
        barplot(as.matrix(p1), main="SOP", ylab= "Score",
                space=0.1, cex.axis=0.8, las=1,names.arg=c("Minimum Score","Your Score"),
                cex=0.8,col=c("red","green"),beside=TRUE
        )
      }
      
      else if (plotType =="LOR"){
        p1 <- c(2, input$lor)
        # par(xpd=T, mar=par()$mar+c(0,0,0,4))
        barplot(as.matrix(p1), main="LOR", ylab= "Score",
                space=0.1, cex.axis=0.8, las=1,names.arg=c("Minimum Score","Your Score"),
                cex=0.8,col=c("red","green"),beside=TRUE
        )
      }
      
      else if (plotType =="CGPA"){
        p1 <- c(3, input$cgpa)
        #par(xpd=T, mar=par()$mar+c(0,0,0,4))
        barplot(as.matrix(p1), main="CGPA", ylab= "Score",
                space=0.1, cex.axis=0.8, las=1,names.arg=c("Minimum Score","Your Score"),
                cex=0.8,col=c("red","green"),beside=TRUE
        )
      }
    })
    
    
    
    #lineChart plot overall
    output$overallPlot <- renderPlot({
      answer <- c(input$gre, input$toefl, input$cgpa, input$univRat, input$sop, input$lor)
      standard <- c(305, 87, 3.0, 2, 2, 2)
      g_range <- range(0, answer, standard+55)
      
      plot(answer, type="o", col="blue", ylim=g_range, 
           axes=FALSE, ann=FALSE)
      axis(1, at=1:6, lab=c("GRE","TOEFL","Univ. Rat.","SOP","LOR", "CGPA"))
      axis(2, las=1, at=50*0:g_range[2])
      box()
      
      lines(standard, type="o",pch=22, lty=2, col="red")
      
      
      title(main="Plotting", col.main="red", font.main=4)
      title(xlab="Topic", col.lab=rgb(0,0.5,0))
      title(ylab="Score", col.lab=rgb(0,0.5,0))
      
      legend("topright", g_range[2], c("answer","standard"), cex=0.8, 
             col=c("blue","red"), pch=21:22, lty=1:2);
    })
    
    
    
    #result data
    output$result <- renderText({
      if (input$gre >= 305 && input$cgpa >=7.0 && input$toefl >= 87 && input$sop >= 2 && input$lor >= 2){
        paste("<span style=\"color:green\">READY TO APPLY FOR MASTERS DEGREE</span>")
      } 
      else (
        paste("<span style=\"color:red\">NOT READY TO APPLY FOR MASTERS DEGREE</span>")
      )
    })
    
    
    
    #predict score for user who applying master degree
    predictScore <- reactive ({predict(model2User,data.frame(GRE.Score=input$gre,TOEFL.Score=input$toefl,
                                                             University.Rating=input$univRat,SOP=input$sop,
                                                             LOR=input$lor,CGPA=input$cgpa,Research=input$research))})
    output$predictScore <- renderText({
      predictScore()
    })
    
    
    
    #data recommendation greTest
    output$greTest <- renderText({
      if (input$gre < 305){
        paste("You need to increase your GRE Score ", 305 - input$gre," more")
      }
      
      else if (input$gre == 305){
        ("Your GRE Score is on the Minimum Score")
      }
      else (
        ("Your GRE Score is Above the Minimum Score")
      )
      
    })
    
    #data recommendation toeflTest
    output$toeflTest <- renderText({
      if (input$toefl < 87){
        paste("You need to increase your TOEFL Score ", 87 - input$toefl," more")
      }
      else if (input$toefl == 87){
        ("Your TOEFL Score is Above the Minimum Score")
      }
      else (
        ("Your TOEFL Score is Above the Minimum Score")
      )
      
    })
    
    #data recommendation lorTest
    output$lorTest <- renderText({
      if (input$lor < 2){
        paste("You need to increase your LOR Strength ", 2 - input$lor," more")
      }
      else if (input$lor == 2){
        ("Your LOR Strength is on the Minimum Standard")
      }
      else (
        ("Your LOR Strength is Above the Minimum Standard")
      )
      
    })
    
    #data recommendation sopTest
    output$sopTest <- renderText({
      if (input$sop < 2){
        paste("You need to increase your LOR Strength ", 2 - input$sop," more")
      }
      else if (input$sop == 2){
        ("Your LOR Strength is on the Minimum Standard")
      }
      else (
        ("Your LOR Strength is Above the Minimum Standard")
      )
      
    })
    
    #data recommendation cgpaTest
    output$cgpaTest <- renderText({
      if (input$cgpa < 7.0){
        paste("You need to increase your CGPA Score ", 7.0 - input$cgpa," more")
      }
      else if (input$cgpa == 7.0){
        ("Your CGPA Score is on the Minimum Score")
      }
      else (
        ("Your CGPA Score is Above the Minimum Score")
      )
      
    })
    
    
    
    #kaggle sample data
    output$sampleDataTable <- renderTable({
      print(data)
    })

    #kaggle linear regression MAE
    output$lmMae <- renderText({
      print(lmMae)
    })
    
    #kaggle random forest MAE
    output$rfMae <- renderText({
      print(rfMae)
    })
    
    #kaggle decission tree MAE
    output$dtMae <- renderText({
      print(dtMae)
    })
    
    
    #kaggle linear regression checker Box
    output$valueLm <- renderText({ 
      if (input$checkBoxLm == TRUE){
        paste("MAE = ",lmMae)
      }
    })
    
    #kaggle random forest checker Box
    output$valueRf <- renderText({ 
      if (input$checkBoxRf == TRUE){
        paste("MAE = ",rfMae)
      }
    })
    
    #kaggle decission tree checker Box
    output$valueDt <- renderText({ 
      if (input$checkBoxDt == TRUE){
        paste("MAE = ",dtMae)
      }
    })
    
    
    
    #kaggle error Table
    a = print(errorTable)
    output$errorTable <- renderTable(a,spacing ="l",digits=10)
    
    
    
    #kaggle predict Testing data
    output$predictTable <- renderPrint({
      print(predictTable)
    })
    
    
    #kaggle predict Training data
    output$predictTable2 <- renderPrint({
      print(predictTable2)
    })
    
    
    
    
    
    
  })
