#   REFERENCE  :  -https://www.kaggle.com/gaukharka/my-first-kernel-graduate-admission-analysis
#                 -https://www.kaggle.com/naishalthakkar/gre-dataset-analysis
#                 -https://www.kaggle.com/mohansacharya/graduate-admissions
#                 -https://www.kaggle.com/ajeetchaudhary/graduate-admissions


#library are used
library(caTools)
library(randomForest)
library(modelr)
library(rpart)
library(forecast)



#load the data
original <- read.csv("./Admission_Predict.csv")
data = original

#df1 for training and testing data set
df1 = original

#df2 for predicted table
df2 = original

#user for applying master degree
user = original
user$Serial.No.= NULL

#assume chance of admit >= 0.5 set Admit to 1, otherwise 0
df2$Chance.of.Admit=ifelse(df2$Chance.of.Admit>0.5,1,0)



#to hold for not to random
set.seed(212)



#split the sample data into training and test data set
sampleData <- sample(nrow(df1), 0.7*nrow(df1), replace = FALSE)
train <- df1[sampleData,]
test <- df1[-sampleData,]
##str to check the data
#str(train)
#str(test)

#split the sample data into training and test data set (for user who applying master degree)
sampleData2 <- sample(nrow(user), 0.7*nrow(user), replace = FALSE)
trainUser <- user[sampleData2,]
testUser <- user[-sampleData2,]
##str to check the data
#str(trainUser)
#str(testUser)

#split the sample data into training and test data set (for other stuff)
sampleData3 <- sample(nrow(df2), 0.7*nrow(df2), replace = FALSE)
trainPredict <- df2[sampleData3,]
testPredict <- df2[-sampleData3,]
##str to check the data
#str(trainPredict)
#str(testPredict)



#linear regression approach
model1<-lm(Chance.of.Admit~.,data = train)
#summary(model1)



#random forest approach
model2<-randomForest(Chance.of.Admit ~ ., data=train)
#summary(model2)

#random forest approach (for user who applying master degree)
model2User <- randomForest(Chance.of.Admit ~ ., data=trainUser)
#summary(model2User)

#random forest for predict
model2Predict <- randomForest(Chance.of.Admit ~ ., data=trainPredict)
#summary(model2Predict)



#decision tree approach
model3 <-rpart(Chance.of.Admit ~ ., data = train)
#summary(model3)




#mae each approach
lmMae <- mae(model1, data = df1)
rfMae <- mae(model2, data = df1)
dtMae <- mae(model3, data = df1)




#predict model (use the Random Forest approach, because the error is lower than any other approach)
#pred for errorTable
pred <- predict(model2, newdata=test)

#pred2 and pred3 for predictTable Testing
pred2 <- predict(model2Predict, newdata=testPredict)
pred3 <-  ifelse(pred2 > 0.5,1,0)

#pred4 for predictTable2 Training
pred4 <- predict(model2Predict, newdata=trainPredict)
pred5 <- ifelse(pred4 > 0.5,1,0)



#error Table
errorTable <- accuracy(pred, test$Chance.of.Admit)



#predictTable for predict Testing data
predictTable <- table(PREDICTED = pred3, ACTUAL = testPredict$Chance.of.Admit)

#predictTable2 for predict Training data
predictTable2 <- table(PREDICTED = pred5, ACTUAL = trainPredict$Chance.of.Admit)



## real predicted detail
### res <- data.frame(test$Serial.No. , test$Chance.of.Admit, pred)
### sampleTable <- sample_n(res, 120)