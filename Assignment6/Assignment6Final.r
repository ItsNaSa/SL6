# Roll no. 33140
# Batch: L9
# P.S.: Application of Linear regression and Naive bayes on Heart disease dataset to predict the fate (prob. of heart disease)

library('e1071')
library('caret')

# Set working directory
setwd("G:/College/SL6/Assignment6/")

# install.packages(c("caret", "e1071"))

# Read the CSV file and analyse
hdata <- read.csv("../../Sl-VI DataSets/HeartDisease/Cleavland.csv",header=TRUE,sep=",")
names(hdata)
str(hdata)
dim(hdata)

# Change the headers
names(hdata)[1] <- "age"
names(hdata)[2] <- "sex"
names(hdata)[3] <- "cp"
names(hdata)[4] <- "trestbps"
names(hdata)[5] <- "chol"
names(hdata)[6] <- "fbs"
names(hdata)[7] <- "restecg"
names(hdata)[8] <- "thalach"
names(hdata)[9] <- "exang"
names(hdata)[10] <- "oldpeak"
names(hdata)[11] <- "slope"
names(hdata)[12] <- "ca"
names(hdata)[13] <- "thal"
names(hdata)[14] <- "num"

hdata$ca
levels(hdata$ca)[levels(hdata$ca) == "?"]<-"0.0"
hdata
hdata$ca[hdata$ca == 1.0]
typeof(hdata$ca)
nrow(hdata)


# Plotting Fate vs number of records
hdata$num[hdata$num >= 1] <- 1 # Edit the fate to 0 and 1
barplot(table(hdata$num), main="Fate", col="black")

# Plot Fate vs gender
mosaicplot(hdata$sex ~ hdata$num,main="Fate by Gender",
           shade=FALSE,color=TRUE,xlab="Gender", ylab="Heart disease")

# Plot Fate vs Age
mosaicplot(hdata$age ~ hdata$num,main="Fate by Age",
           shade=FALSE,color=TRUE,xlab="Age", ylab="Heart disease")


# Most important step, change the values of NA
levels(hdata$thal)[levels(hdata$thal)=="?"]<-"3.0"

# removal of additional NA
hdata$thal
table(hdata$thal)
# hdata$thal[is.na(hdata$thal)]<-'3.0'


table(hdata$ca)

# import library caTools
library(caTools)
library(e1071)
library(caret)

n<- sapply(hdata[, c(1)], mean) # get the average values
set.seed(123) # generate a pseudo-random number

# Subset
v3 <- hdata[c(11:14),c(2,7:9)]
v3
m<- sapply(v3,max)
m

#  Pseudo-random
set.seed(121)

# Divide the dataset into 2/3 for training, and 1/3 for testing
split = sample.split(hdata$num, SplitRatio = 2/3)
train_hdata = subset(hdata, split == TRUE)
test_hdata = subset(hdata, split == FALSE)

# Apply linear regression for Fate vs age
regressor=lm(formula = num~age, data=train_hdata)

# View(regressor)
regressor
# Apply regression on test data
hd_age_predict = predict(regressor, newdata=test_hdata)
hd_age_predict

# Round the values of fate in prediction
round_age=hd_age_predict
r=round(round_age)
View(r)
r
table(r,test_hdata$num)

typeof(r)

levels(r)
levels(test_hdata$num)

str(r)
r1 = as.data.frame(r)
r1
lm_accuracy = confusionMatrix(as.factor(r1$r),as.factor(test_hdata$num))
lm_accuracy


# APPLICATION OF NB

# 1. converting all values to factor
hdata$age <- factor(hdata$age)
hdata$sex <- factor(hdata$sex)
hdata$cp <- factor(hdata$cp)
hdata$trestbps <- factor(hdata$trestbps)
hdata$chol <- factor(hdata$chol)
hdata$fbs <- factor(hdata$fbs)
hdata$restecg <- factor(hdata$restecg)
hdata$thalach <- factor(hdata$thalach)
hdata$exang <- factor(hdata$exang)
hdata$oldpeak <- factor(hdata$oldpeak)
hdata$slope <- factor(hdata$slope)
hdata$ca <- factor(hdata$ca)
hdata$thal <- factor(hdata$thal)
hdata$num <- factor(hdata$num)

# 2. Divide the factored dataset into 2/3 for training, and 1/3 for testing
split = sample.split(hdata$num, SplitRatio = 2/3)
train_hdata = subset(hdata, split == TRUE)
test_hdata = subset(hdata, split == FALSE)

# 3. Apply Naive Bayes on Dataset
nb_model <- naiveBayes(num ~ age+sex+cp+trestbps+chol+fbs+restecg+thalach+exang+oldpeak+slope+ca+thal,data = train_hdata)
nb_model

# 4. Predict
pred_nb <- predict(nb_model,newdata = test_hdata, type = "class")

# 5. convert to table
table(pred_nb,test_hdata[,14])

# 6. Prepare confusion matrix
nb_accur <- confusionMatrix(as.factor(test_hdata$num),as.factor(pred_nb))

# 7. Display
nb_accur
