#Minna Peralampi
#7.2.2017

#Joining two datasets together.

#Dataset credits:
#Using Data Mining To Predict Secondary School Student Alcohol Consumption. 
#Fabio Pagnotta, Hossain Mohammad Amran 
#Department of Computer Science,University of Camerino


# Setting the working directory 
  setwd("C:/Users/Minna/Documents/GitHub/IODS-project/data")
# Getting access to a useful library
  library(dplyr)
  
#Reading the datasets to R
  math <- read.table(file = "student-mat.csv", sep=";", header=TRUE)
  por <- read.table(file = "student-por.csv", sep=";", header=TRUE)

#Exploring the structure and dimensions of the data
  #st_mat
  str(math)
  dim(por)
  colnames(math)
  #It is a data frame with 395 observations of one variable
  
  #st_por
  str(por)
  dim(por)
  colnames(math)
  #It is a data frame with 649 observations and 1 variable
  
#Joining the two datasets with 13 diffrent variables
  #Making a vector with wanted variables
  join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
  
  #Joining the st_por and st_mat to a mat_por dataset
  mat_por <- inner_join(math, por,  by = join_by, suffix = c(".math", ".por"))
  
  #Little bit of exploring
  str(mat_por)
  dim(mat_por)
  #It is a data frame with 382 observations and 53 variables
  
# Creating a new data frame with only the joined columns
  alc <- select(mat_por, one_of(join_by))

# Dealing with the dublicates
  
  # the columns in the datasets which were not used for joining the data
  notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
  
  for(column_name in notjoined_columns) {
    # select two columns from 'math_por' with the same original name
    two_columns <- select(mat_por, starts_with(column_name))
    # select the first column vector of those two columns
    first_column <- select(two_columns, 1)[[1]]
    
    # if that first column vector is numeric...
    if(is.numeric(first_column)) {
      # take a rounded average of each row of the two columns and
      # add the resulting vector to the alc data frame
      alc[column_name] <- round(rowMeans(two_columns))
    } else { # else if it's not numeric...
      # add the first column vector to the alc data frame
      alc[column_name] <- first_column
    }
  }
  
#Creating alc_use and high_use columns
  alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
  alc <- mutate(alc, high_use = alc_use > 2)
  

#Checking the data with Glimpse
  glimpse(alc)
  
  #Observations: 382
  #Variables: 35
  
  write.csv(alc, file = "alc", row.names = F)
  
  
  
   