#prediction for newdatasets
setwd("~/Downloads/BigmartSales-master")
#load the datasets
ndata <- read.csv("Test.csv")

#load the model
lm0 <- readRDS("BigMart.Rdata")

Targ<- ndata$Item_Outlet_Sales
ndata<- subset(ndata, select=-c(Item_Outlet_Sales))

source("processing.R")

new_data <- processT(ndata)


#predict the value
#predict the test data
predtest <- predict(lm0,newdata = new_data)

outputMod <- predtest
outputMod[predtest<0]<- 0
Item_Identifier<-new_data$Item_Identifier
Outlet_Identifier <- new_data$Outlet_Identifier
Item_Outlet_Sales<- outputMod
output <- data.frame(Item_Identifier,Outlet_Identifier,Item_Outlet_Sales)

write.csv(output,'SampleSubmission.csv', row.names = F)

