credit = read.csv("credit.csv", head = TRUE )
head(credit)
balance = credit$Balance
lm0 = lm(balance~.,data = credit)
summary(lm0)
library(MASS)
step <- stepAIC(lm0, direction="both")
step$anova # display results
library(leaps)
lm1 = regsubsets(balance~., credit,nbest = 2)
summary(lm1)
gender = credit$Gender
levels(gender)
levels(credit$Ethnicity)
levels(credit$Student)
lm2 = lm(balance ~.,data = credit)
summary(lm2)
lm3 = regsubsets(balance ~., data = credit)
summary(lm3)$rss
summary(lm3)$bic
summary(lm3)$cp
lm4 = regsubsets(balance ~., data = credit,method = "forward")
summary(lm4)$rss
summary(lm4)$bic
summary(lm4)$cp
lm5 = regsubsets(balance ~., data = credit,method = "backward")
summary(lm5)$rss
summary(lm5)$bic
summary(lm5)$cp
par(mfrow = c(1,1))
plot(summary(lm3)$rss,pch = 0,main = "RSS of three mehods",ylab = "RSS")
points(summary(lm4)$rss,pch = 2)
points(summary(lm5)$rss,pch = 4)
leg.txt = c("exhaustive","forward","backward ")
legend("topright",leg.txt,pch= c(0,2,4))
par(mfrow = c(1,3))
plot(lm3,scale = "Cp")
plot(lm4,scale = "Cp")
plot(lm5,scale = "Cp")
plot(lm3,scale = "bic")
plot(lm4,scale = "bic")
plot(lm5,scale = "bic")
summary(lm3,scale = "Cp")
summary(lm4,scale = "Cp")
summary(lm5,scale = "Cp")
summary(lm3,scale = "bic")
summary(lm4,scale = "bic")
summary(lm5,scale = "bic")
#

sym1 = c("MMM","AXP","AAPL","BA","CAT","CVX","CSCO","KO","DD","XOM","GE",
         "GS","HD","IBM","INTC","JNJ","JPM","MCD","MRK","MSFT","NKE","PFE",
         "PG","TRV","UNH","UTX","VZ","V","WMT","DIS")
web = NULL
title = NULL
stock = NULL
for (i in 1:length(sym1)){
  web[i] = paste0("http://chart.finance.yahoo.com/table.csv?s=", sym1[i],"&a=0&b=1&c=2010&d=0&e=1&f=2011&g=d&ignore=.csv",sep = "")
  title[i] = paste(sym1[i],".csv",sep = "")
  download.file (web[i],title[i],quiet = FALSE)
}
d = c(1:252)
 pr= matrix(d,nrow = 252,ncol = 30)
colnames(d) = c("mmm","aapl")

for( i in 1:length(sym1))
{
  stock = read.csv(title[i],header = T)
  m = stock$Close
  pr[,i] = m
}
colnames(pr) = sym1
str(pr)
View(pr)
par(mfrow = c(1,1))
pca1 = princomp(pr, cor = FALSE)
biplot(pca1)
screeplot(pca1)
pca2 = princomp(pr, cor = T,center = TRUE,scale. = TRUE)
biplot(pca2)
screeplot(pca2)
return = NULL
for (i in 1:30){
  return[i] = exp(diff(log(pr[i]))) - 1
}
ret<-exp(diff(log(pr)))-1
pr1 = pr[-1,]
pr2 = pr[-252,]
ret1 = pr1 - pr2
pca3= princomp(ret, cor = T,center = TRUE,scale. = TRUE)
pca3= princomp(ret1, cor = T,center = TRUE,scale. = TRUE)
biplot(pca3)
screeplot(pca3)
