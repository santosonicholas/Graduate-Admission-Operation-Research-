# GRADUATE ADMISSION OPERATION RESEARCH

## GETTING STARTED

### Prerequisites

What things you need to install the software and how to install them

[R](https://cran.r-project.org/bin/windows/base/)

[R Studio](https://www.rstudio.com/products/rstudio/download/#download)

### Library are used for this program

```
library(shiny)
library(shinythemes)
library(caTools)
library(randomForest)
library(modelr)
library(rpart)
library(forecast)
```

### Installing

A step by step series of examples that tell you how to get a development env running

1. Download the file from the **Github Repository**
2. Open ui.R on your **R Studio**
3. Click RunApp Button on your **R Studio**

![openFile](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/openFile.gif)


## GRADUATE ADMISSION PROGRAM DETAILS

### Features of This Program

#### 1. Apply Master Program By Inputting Your Data

In this program you can test for graduate admission with your data(GRE Score, TOEFL Score, CGPA, University Rating, Statement of Purpose(SOP), Letter of Recommendation(LOR), Research, Chance of Admit) by inputing to this program.

![inputData](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/inputData.gif)


#### 2. View the Result of Your Input Data

The Result Tab is for showing the result of your data whether are you qualified for applying master degree or not.

We have done some research online to find the minimum standard score for applying for a masters degree, which we have taken from the UCLA miniumum standard and used it in our program (you can see the minimum standard score in the *Minimum Score Criteria* tab).

![viewResult](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/viewResult.gif)


#### 3. View Your Input Data as a Graphical Plot

We have added bar plots which user can select from, which displays the user inputted data and the minimum score per category. There is also a line chart which displays all the inputted score and minimum score in a line.

![viewPlot](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/viewPlot.gif)


#### 4. Analysis Kaggle Graduate Admission Problem

In this program we analyze and predict the data that are given in the link down below.
[Kaggle Link](https://www.kaggle.com/mohansacharya/graduate-admissions)

#### 5. Training the Data With the Linear Regression, Random Forest, and Decission Tree Approach

We train the data to find the error and make a prediction.

![approach](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/approach.gif)

#### 6. View the Error Data

In this tab you can see the error data table which includes Mean Error(ME), Root Mean Square ERROR(RMSE), MEAN ABSOLUTE ERROR(MAE), MEAN PERCENTAGE ERROR(MPE), MEAN ABSOLUTE PERCENTAGE ERROR(MAPE).

![errorTable](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/errorTable.PNG)

#### 7. Predict the Data

You can see the prediction of the testing data in the picture down below.

![predictTable1](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/predictTable1.PNG)

You can see the prediction of the training data in the picture down below.

![predictTable2](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/predictTable2.PNG)


### Code Explanation

First you need to import the sample data set.

*Import Data*
```R
original <- read.csv("./Admission_Predict.csv")
```

In this segment our program needs to make a lot of variable to hold the data sets, because our program needs data sets to be applied differently from each other.

*Make Variable to Hold the Data*
```R
#df1 for training and testing data set
df1 = original

#df2 for predicted table
df2 = original

#user for applying master degree
user = original
user$Serial.No.= NULL
```

For this data set we assume that if the chance of admit is lower than 0.5 we assume it as 0, otherwise if the chance of admit is greater than 0.5 we assume it as 1 (this will help to get predicted more easily).

```R
df2$Chance.of.Admit=ifelse(df2$Chance.of.Admit>0.5,1,0)
```

For training and testing our data sets, we split the data into 70%(Train) and 30%(Test).

*Split Data Into Training and Data Sets*
```R
#split the sample data into training and test data set
sampleData <- sample(nrow(df1), 0.7*nrow(df1), replace = FALSE)
train <- df1[sampleData,]
test <- df1[-sampleData,]

#split the sample data into training and test data set (for user who applying master degree)
sampleData2 <- sample(nrow(user), 0.7*nrow(user), replace = FALSE)
trainUser <- user[sampleData2,]
testUser <- user[-sampleData2,]

#split the sample data into training and test data set (for other stuff)
sampleData3 <- sample(nrow(df2), 0.7*nrow(df2), replace = FALSE)
trainPredict <- df2[sampleData3,]
testPredict <- df2[-sampleData3,]
```

In this section we focus on finding the smallest error from the 3 approach we are using **(linear regression, random forest, decission tree)**.

*Linear Regression Approach*
```R
model1<-lm(Chance.of.Admit~.,data = train)
```

*Random Forest Approach*
```R
#random forest approach
model2<-randomForest(Chance.of.Admit ~ ., data=train)

#random forest approach (for user who applying master degree)
model2User <- randomForest(Chance.of.Admit ~ ., data=trainUser)

#random forest for predict
model2Predict <- randomForest(Chance.of.Admit ~ ., data=trainPredict)
```

*Decission Tree Approach*
```R
model3 <-rpart(Chance.of.Admit ~ ., data = train)
```

*Get MAE Each Approach*
```R
lmMae <- mae(model1, data = df1)
rfMae <- mae(model2, data = df1)
dtMae <- mae(model3, data = df1)
```

***MAE Output***

![mae](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/mae.PNG)

We can see that Random Forest Approach have the smallest error compared to the 2 other approach, now that we know which approach have the smallest error, we take the **random forest** approach model and use the model for the testing data set.

Next we predict the data with data testing, but before that we need to find the error table first to see what is the error we have.

*Predict For Error Table*
```R
pred <- predict(model2, newdata=test)
```

*Error Table*
```R
errorTable <- accuracy(pred, test$Chance.of.Admit)
```

***Error Table Output***

![errorTableSyntax](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/errorTableSyntax.PNG)

In this step we want to show the predicted data sample to know if this data sets are truly correct or false with the confusion matrix.

*Predict Table Testing*
```R
#pred2 and pred3 for predictTable Testing
pred2 <- predict(model2Predict, newdata=testPredict)
pred3 <-  ifelse(pred2 > 0.5,1,0)

predictTable <- table(PREDICTED = pred3, ACTUAL = testPredict$Chance.of.Admit)
```

***Predict Table Testing Output***

![predictTableTesting](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/predictTableTesting.PNG)


*Predict Table Training*
```R
#pred4 for predictTable2 Training
pred4 <- predict(model2Predict, newdata=trainPredict)
pred5 <- ifelse(pred4 > 0.5,1,0)

predictTable2 <- table(PREDICTED = pred5, ACTUAL = trainPredict$Chance.of.Admit)
```

***Predict Table Training Output***

![predictTableTraining](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/predictTableTraining.PNG)


## Conclusion

The conclusion is that every approach such as linear regression, random forest, decision tree, etc, are different with each other, but luckily this program works best with the Random Forest approach because the error is the least.

The result of the prediction is already shown at explanation above, we can conclude that 90% data is truly correct with the 10% error of the data, the error means there that is no synchronization between the data and the prediction.

## Built With

* [R](https://cran.r-project.org/bin/windows/base/)
* [R Studio](https://www.rstudio.com/products/rstudio/download/#download)

## Authors

* **Johny Huang** - INFORMATICS UPH 2017 
* **Nicholas** - INFORMATICS UPH 2017
* **Leon Chrisdion** - INFORMATICS UPH 2017

## Acknowledgments

* Kaggle Reference taken from [Gaukharka](https://www.kaggle.com/gaukharka/my-first-kernel-graduate-admission-analysis)
* Kaggle Reference taken from [Naishalthakkar](https://www.kaggle.com/naishalthakkar/gre-dataset-analysis)
* Kaggle Reference taken from [Mohansacharya](https://www.kaggle.com/mohansacharya/graduate-admissions)
* Kaggle Reference taken from [Ajeetchaudhary](https://www.kaggle.com/ajeetchaudhary/graduate-admissions)
* Graduate Admission Case from [Kaggle](https://www.kaggle.com/mohansacharya/graduate-admissions)
