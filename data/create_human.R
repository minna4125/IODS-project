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
  #Accessiing to the dplyr and tidyr and stringr library
  library(dplyr)
  library(tidyr)
  library(stringr)
    
  #Joining the two datsets
  human <- inner_join(hd, gii, by = "country")
  
  #Checking the human dataset
  dim(human)
  
  #Dimensions are right. Saving the dataset in the data folder
  write.csv(human, file = "human", row.names = F)
  
# Changing GNI variable in human2 to numeric 
  library(stringr)
  human2 <- read.csv("human", header = T, sep = ",", stringsAsFactors = F)
  human2$GNI <- as.numeric(gsub(",", ".", human2$GNI))

  
# Variables to keep
  keep <- c("country", "edu2.ratio", "lab.ratio", "life.exp", "edu.exp", "GNI", "MMR", "ABR", "Pr.parl")
  
# Selecting the keep variables
  human2 <- select(human2, one_of(keep))
  
# Removing rows with NA values
  human2 <- filter(human2, complete.cases(human2))

# Removing rows with regions
  last <- nrow(human2) - 7
  human2 <- human2[1:last, ]
  
# Changing rownames to country names
  rownames(human2) <- human2$country
  
# Removing country column
  human2 <- select(human2, -country)

#Cheking that it is right  
 dim(human2)
 summary(human2)

#Writing new human file  
  write.csv(human2, file = "human2", row.names = T)
 
  
  
  