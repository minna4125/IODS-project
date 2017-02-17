# Human data wrangling
## Minna Peralampi
## 17.2.2017

#Reading the "Human development" data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", 
               stringsAsFactors = F)

#Reading the "Gender inequality" data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", 
                stringsAsFactors = F, na.strings = "..")


#Exploring the datasets
  #Human development
    str(hd)
    dim(hd)
  #It has 195 observations of 8 variables.
    
  #Gender inequality
    str(gii)
    dim(gii)
  #It has 195 observations of 10 variables

    
#Looking at the current variable names
    #Human development
    colnames(hd)
    # Gender inequality
    colnames(gii)
    
#Changing them with more convenient (shorter versions).
    names(hd) <- c("HDI.rank","country", "HDI", "life.exp", "edu.exp", 
                   "mean.edu", "GNI", "GNI.minus.rank")
    
    #Changing names in GI data
    names(gii)<-c("GII.rank", "country", "GII", "MMR", "ABR","Pr.parl", "edu.2F",
                  "edu.2M", "labF", "labM")

    
#Mutating the GI data
    #Creating female/male ratios in secondary education and in work force
    edu2.ratio <- gii$edu.2F/gii$edu.2M
    lab.ratio <- gii$labF/gii$labM
    
    #Adding them to the GI data
    gii$edu2.ratio <- edu2.ratio
    gii$lab.ratio <- lab.ratio

    
#Joining the two datasets
  #Accessiing to the dplyr library
  library(dplyr)
    
  #Joining the two datsets
  human <- inner_join(hd, gii, by = "country")
  
  #Checking the human dataset
  dim(human)
  
  #Dimensions are right. Saving the dataset in the data folder
  write.csv(human, file = "human", row.names = F)
  
    