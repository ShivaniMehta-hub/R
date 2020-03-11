## Performance Evaluations
## Last Updated: February 3, 2020


pacman::p_load(caret, data.table, e1071, fpp2, gains, pROC)


  ## Prediction Example (using ToyotaCorolla)
toyota.corolla.df <- fread("ToyotaCorolla.csv")

  ### randomly generate training and validation sets
set.seed(42)
training <- sample(toyota.corolla.df$Id, 600)
validation <- sample(setdiff(toyota.corolla.df$Id, training), 400)

  # Sample algorithm: Linear Regression
reg <- lm(Price~., data=toyota.corolla.df[training,-c(1,2,8,11)], na.action=na.exclude)
pred_t <- predict(reg)
pred_v <- predict(reg, newdata=toyota.corolla.df[validation,-c(1,2,8,11)])


   ### Evaluate performance
options(scipen = 999)

  # Accuracy
accuracy(pred_t, toyota.corolla.df[training,]$Price)
accuracy(pred_v, toyota.corolla.df[validation,]$Price)


    ### Compute gains relative to price
gain <- gains(toyota.corolla.df[validation,]$Price[!is.na(pred_v)], pred_v[!is.na(pred_v)])
price <- toyota.corolla.df[validation,]$Price[!is.na(toyota.corolla.df[validation,]$Price)]
plot(c(0,gain$cume.pct.of.total*sum(price))~c(0,gain$cume.obs), 
     xlab="# cases", ylab="Cumulative Price", main="Lift Chart", 
     col = "blue1", type="l")
lines(c(0,sum(price))~c(0,dim(toyota.corolla.df[validation,])[1]), col="brown2", lty=2)


  ### Decile-wise lift chart
barplot(gain$mean.resp/mean(price), names.arg = gain$depth, space = 1.3,
        xlab = "Percentile", ylab = "Mean Response", main = "Decile-wise lift chart",
        col = "coral1", border = NA)





  ## Classification Example - Confusion Matrix and Misclassification Rate

owner.df <- read.csv("ownerExample.csv")
confusionMatrix(as.factor(ifelse(owner.df$Probability>0.5, 'owner', 'nonowner')), owner.df$Class)
confusionMatrix(as.factor(ifelse(owner.df$Probability>0.25, 'owner', 'nonowner')), owner.df$Class)
confusionMatrix(as.factor(ifelse(owner.df$Probability>0.75, 'owner', 'nonowner')), owner.df$Class)



  ## Accuracy and Misclassifcation Rate as a funcion on Cut-off rate

df <- read.csv("liftExample.csv")

  ### ROC Curve
library(pROC)
r <- roc(df$actual, df$prob)
plot.roc(r)
  ### compute auc
auc(r)


  ## Lift Charts

#library(gains)
gain <- gains(df$actual, df$prob, groups=dim(df)[1])
plot(c(0, gain$cume.pct.of.total*sum(df$actual)) ~ c(0, gain$cume.obs), 
     xlab = "# cases", ylab = "Cumulative", type="l",
     col="blue1")
lines(c(0,sum(df$actual))~c(0,dim(df)[1]), col="red1", lty=2)


  ### Decile Lift Charts
gain <- gains(df$actual, df$prob)
barplot(gain$mean.resp / mean(df$actual), names.arg = gain$depth, xlab = "Percentile", space = 1.3,
        ylab = "Mean Response", main = "Decile-wise lift chart", col = "seagreen", border = NA)

