
library (shiny)
library (shinythemes)

shinyUI(fluidPage(
  theme = shinytheme("slate"),
  
  navbarPage(
    title = "GRADUATE ADMISSION TEST PROGRAM",
    id = "nav",
    tabPanel("Apply Masters Degree",value = "Apply Masters Degree",
             sidebarLayout(
               sidebarPanel(
                 helpText("Please Fill the Needed Informations Down Below !"),
                 
                 textInput("name","Name :"),
                 
                 sliderInput ("gre", "GRE Score :",
                              min=0, max=340, value= 0, step=1),
                 
                 sliderInput ("toefl", "TOEFL Score :",
                              min=0, max=120, value= 0, step=1),
                 
                 sliderInput ("univRat", "University Rating :",
                              min=0, max=5, value= 0, step=1),
                 
                 sliderInput ("sop", "Statement of Purpose (SOP) :",
                              min=0, max=5, value= 0, step=0.5),
                 
                 sliderInput ("lor", "Letter of Recommendation Strength (LOR) :",
                              min=0, max=5, value= 0, step=0.5),
                 
                 sliderInput ("cgpa", "Undergraduate CGPA :",
                              min=0, max=10, value= 0, step=0.01),
                 
                 sliderInput ("research", "Research Experience :",
                              min=0, max=1, value= 0, step=1),
                 
                 sliderInput ("chanceAdmit", "Chance of Admit :",
                              min=0, max=1, value= 0, step=0.01)
               ),
               
               mainPanel(
                 h2(strong(textOutput("subHead"))),
                 br(),
                 
                 tabsetPanel(
                   tabPanel("Summary", tableOutput("summaryValues")),
                   tabPanel("Minimum Score Criteria", tableOutput("minimumValues")),
                   tabPanel("Graphical View", 
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("plot","Bar Charts",
                                            choices = c("GRE", "TOEFL", "SOP", "LOR", "CGPA")
                                )
                              ),
                              mainPanel(
                                plotOutput("plotChart")
                              )
                            )
                   ),
                   tabPanel("Overall Charts",
                            plotOutput("overallPlot")),
                   tabPanel("Result", 
                            h3((htmlOutput("result"))),
                            br(),
                            br(),
                            br(),
                            #h4("User Predict Percentage"),
                            #textOutput("predictScore"),
                            h2("Data Recommendation"),
                            h5(textOutput("greTest")),
                            h5(textOutput("toeflTest")),
                            h5(textOutput("cgpaTest")),
                            h5(textOutput("lorTest")),
                            h5(textOutput("sopTest"))
                            )
                 )
               ) 
               
             )
            ),
    
    tabPanel("Kaggle Case", values = "Kaggle Case",
             h2(strong("KAGGLE GRADUATE ADMISSION")),
             h3(shiny::a(em("Click here to open the link"), href="https://www.kaggle.com/mohansacharya/graduate-admissions")),
             br(),
             h4(em("Context")),
             h5("This dataset is created for prediction of Graduate Admissions from an Indian perspective."),
             br(),
             h4(em("Content")),
             h5("The dataset contains several parameters which are considered important during 
                the application for Masters Programs. The parameters included are : 
                1. GRE Scores 
                ( out of 340 ) 
                2. TOEFL Scores ( out of 120 ) 
                3. University Rating ( out of 5 ) 
                4. Statement of Purpose and Letter of Recommendation Strength ( out of 5 ) 
                5. Undergraduate GPA ( out of 10 ) 
                6. Research Experience ( either 0 or 1 ) 
                7. Chance of Admit ( ranging from 0 to 1 )"),
             br(),
             h4(em("Acknowledgements")),
             h5("This dataset is inspired by the UCLA Graduate Dataset. 
                The test scores and GPA are in the older format. 
                The dataset is owned by Mohan S Acharya."),
             br(),
             h4(em("Inspiration")),
             h5("This dataset was built with the purpose of helping students in shortlisting universities with their profiles. 
                The predicted output gives them a fair idea about their chances for a particular university."),
             br(),
             h4(em("Citation")),
             h5("Please cite the following if you are interested in using the dataset : 
                Mohan S Acharya, Asfia Armaan, Aneeta S Antony : A Comparison of Regression Models for Prediction of Graduate Admissions, 
                IEEE International Conference on Computational Intelligence in Data Science 2019.
                I would like to thank all of you for contributing to this dataset through discussions and questions. 
                I am in awe of the number of kernels built on this dataset. Some results and visualisations are 
                fantastic and makes me a proud owner of the dataset. Keep em' coming! Thank You."),
             br(),
             tabsetPanel(
               tabPanel("Sample Data", tableOutput("sampleDataTable")),
               
               tabPanel("Training Data",
                        fluidPage(
                          h2(em(checkboxInput("checkBoxLm", label = "Linear Regression", value = FALSE))),
                          hr(),
                          fluidRow(column(3, h3(strong(textOutput("valueLm"))))),
                          br(),br(),br(),
                          h2(em(checkboxInput("checkBoxRf", label = "Random Forest", value = FALSE))),
                          hr(),
                          fluidRow(column(3, h3(strong(textOutput("valueRf"))))),
                          br(),br(),br(),
                          h2(em(checkboxInput("checkBoxDt", label = "Decission Tree", value = FALSE))),
                          hr(),
                          fluidRow(column(3, h3(strong(textOutput("valueDt"))))),
                          br(),br(),br(),br(),
                          strong(em("*Information")),
                          br(),
                          em("MAE: Mean Absolute Error")
                        )
                  ),
                tabPanel("Testing Data",
                          h2("Random Forest Approach MAE is much smaller than MAE other Approach"),
                          h3("Error Table"),
                          tableOutput("errorTable"),
                          br(),br(),br(),br(),
                          strong(em("*Information")),
                          br(),
                          em("ME: Mean Error"),
                          br(),
                          em("RMSE: Root Mean Squared Error"),
                          br(),
                          em("MAE: Mean Absolute Error"),
                          br(),
                          em("MPE: Mean Percentage Error"),
                          br(),
                          em("MAPE: Mean Absolute Percentage Error")
                  ),
                tabPanel("Prediction",
                          h3(strong("Prediction Testing Data")),
                          fluidRow(column(3,h2(verbatimTextOutput("predictTable")))),
                          h3(strong("Prediction Training Data")),
                          fluidRow(column(3,h2(verbatimTextOutput("predictTable2"))))
                  )
               )),
       tabPanel("About",values="About",
               h2(strong("OPERATION RESEARCH PROJECT")),
               br(),br(),
               h3(shiny::a(em("GITHUB LINK"), href="https://github.com/santosonicholas/Graduate-Admission-Operation-Research-")),
               br(),br(),
               h3("TEAM MEMBER :"),
               h4("Nicholas / 01082170001"),
               h4("Leon / 01082170013"),
               h4("Johny / 01082170004"),
               br(),
               h4("UPH INFORMATICS 2017"),
               br(),br(),br(),br(),br(),br(),br(),br(),br(),
               br(),br(),br(),br(),br(),br(),br(),br(),br(),
               h5("2019 - Copyright , Term & Conditions Applied")
              )
        )
    )
)

