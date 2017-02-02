# Minna Perälampi
# 27.1.2017
# RStudio Exercise 2 for IODS


# 2 Getting familiar with the structure and dimensions of the data
  
  

  # Reading the data from the website to "lrn2014"
  lrn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
  
  # getting access to the useful dplyr library
  library(dplyr)
  
  # Exploring the structure of the data
  str(lrn2014)
  
  #Exploring the dimensions of learning2014
  dim(lrn2014)
  
  #Structure of the data is a data frame with 183 observations and 60 variables.
 

#3 Creating an analysis dataset with variables: 
  #   -gender, Age, Attitude, deep, stra, surf and Points
  #   Making deep, stra and surf variables
  
  #Combining the questions(q=questions)
  deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
  surface_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
  strategic_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
  
  #Creating columns "deep", "surf", and "stra" by averaging (c=columns)
    
    #deep
    deep_c <- select(lrn2014, one_of(deep_q))
    lrn2014$deep <- rowMeans(deep_c)
    
    #surf
    surface_c <- select(lrn2014, one_of(surface_q))
    lrn2014$surf <- rowMeans(surface_c)
    
    #stra
    strategic_c <- select(lrn2014, one_of(strategic_q))
    lrn2014$stra <- rowMeans(strategic_c)
  
  
  
  # Making the vector with wanted variables.
  w_variables <- c("gender", "Age", "Attitude", "deep", "stra" ,"surf", "Points")
  
  # Making the dataset (learning2014) we want with wanted_variables vector
  learning2014 <- select(lrn2014, one_of(w_variables))
  
  #Getting rid of the CAPITAL letters in some variables
  #Finding those things
  colnames(learning2014)
  #Renaming them
  colnames(learning2014)[2] <- "age"
  colnames(learning2014)[3] <- "attitude"
  colnames(learning2014)[7] <- "points"
  
  #Excluding the zeroes
  learning2014 <- filter(learning2014, points > 0)
  
  
  #Cheking that the dimensions are right
  dim(learning2014)
  
  #Dimensions are right(166, 7)
  
  
# 4 Saving the dataset "learning2014" to csv file
  write.csv(learning2014, file = "learning2014.csv", row.names=FALSE)
  
  #Demonstrating that it is still usable
  check_lrn14 <- read.csv("learning2014.csv")
  
  #Checking that the data is right
  str(check_lrn14)
  head(check_lrn14)
  
  
  
  
  
  
  


