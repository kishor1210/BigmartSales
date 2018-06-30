#Processing of data for Bigmart Sales
processT <- function(df){
  
  dataset <- df
  #Load Library
  library(DMwR) #for knnImputation
  
  #Check for null value
  colSums(is.na(dataset))

  
  #Remove null Value by using KNN
  dataset <- knnImputation(dataset, k= 6, meth="weighAvg")
  
  #Explore with Item_Fat_Content
  unique(dataset$Item_Fat_Content)

  # As per the dataset we have 5 type of fat contents but actually it is only two "Regular" and "Low Fat".
  #So we are converting it in actual data content
  dataset$Item_Fat_Content[dataset$Item_Fat_Content == "reg"] <- "Regular"
  dataset$Item_Fat_Content[dataset$Item_Fat_Content == "LF" | dataset$Item_Fat_Content == "low fat"]<- "Low Fat"
  
  
  str(dataset)
  summary(dataset)
  
  #Some of the outlet size are empty
  levels(dataset$Outlet_Size)[1]<-"others"
  
  
  #Item visiblity should not be zero.
  dataset$Item_Visibility[dataset$Item_Visibility == 0]<- mean(dataset$Item_Visibility)
  
  #How old Outlet_Establishment is. as the data is taken in 2013
  dataset$Outlet_Establishment_Year<- 2013-dataset$Outlet_Establishment_Year

  #return the dataset
  dataset
  
  
}




