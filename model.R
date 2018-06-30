setwd("~/Downloads/BigmartSales-master")
#load data
df <- read.csv("Train.csv") 

df <-df[!(is.na(df$Item_Outlet_Sales)),]

Item_Outlet_Sales <- df$Item_Outlet_Sales
df<-subset(df, select=-c(Item_Outlet_Sales))
#summary(Item_Outlet_Sales)
#str(df)
#summary(df)

source("processing.R")
rd<-processT(df)
str(rd)
summary(rd)

#combine the independant and dependant variable for training
train <- cbind(rd,Item_Outlet_Sales)

#Lets develop the model
lm0 <- lm(Item_Outlet_Sales ~., data = train)
summary(lm0)

#Using StepAic
stepOut <- stepAIC(lm0, direction = "both")
summary(step)

#save the model in Rdata form
saveRDS(lm0,"lm0.Rdata")