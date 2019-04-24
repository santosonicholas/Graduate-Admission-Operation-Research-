# GRADUATE ADMISSION OPERATION RESEARCH

## GETTING STARTED

### Prerequisites

What things you need to install the software and how to install them

[R Language](https://cran.r-project.org/bin/windows/base/)

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

#### 1. Apply Master Program By Inputting Your Data, 

![inputData](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/inputData.gif)


#### 2. View the Result of Your Input Data

![viewResult](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/viewResult.gif)


#### 3. View Your Input Data as a Graphical Plot

![viewPlot](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/viewPlot.gif)


#### 4. Analysis Kaggle Graduate Admission Problem

[Kaggle Link](https://www.kaggle.com/mohansacharya/graduate-admissions)

#### 5. Training the Data With the Linear Regression, Random Forest, and Decission Tree Approach

![approach](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/approach.gif)

#### 6. View the Error Data

![errorTable](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/errorTable.PNG)

#### 7. Predict the Data

![predictTable1](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/predictTable1.PNG)


![predictTable2](https://github.com/santosonicholas/Graduate-Admission-Operation-Research-/blob/master/image/predictTable2.PNG)


### Code Exlpanation

*Import Data*
```R
original <- read.csv("./Admission_Predict.csv")
```

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


Because Random Forest MAE is Smaller than MAE Other Approach, I Use Random Forest MAE Training Data For Testing Data

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

The conclusion is every approach such as linear regression, random forest, decission tree, etc, are different with each other, but luckily this program are better using with the Random Forest approach because the error is less than linear regression and decission tree.

The result of the prediction is already shown at explanation above, we can conclude that 90% data is trully correct with the 10% error of the data, error means there is no synchronization between the data and the prediction.

## Built With

* [R Language](https://cran.r-project.org/bin/windows/base/)
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
