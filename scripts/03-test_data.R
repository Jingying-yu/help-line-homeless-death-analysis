#### Preamble ####
# Purpose: Tests cleaned data to ensure all classes, values, etc. of variables are kept/included
# Author: Sandy Yu
# Date: 5 March, 2024
# Contact: jingying.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: written code for data cleaning


#### Workspace setup ####
library(tidyverse)


#### Test data ####
# Test for missing values
anyNA(cleaned_data) == FALSE
  
# Test for correlation between numeric variables
correlation <- cor(cleaned_data[, 2:5])
all(correlation >= -1 & correlation <= 1) == TRUE
  
# Test for the correct data type of the Month_date column
class(cleaned_data$Month_date) == "Date"
class(cleaned_data$Total_Coded) == "numeric"
class(cleaned_data$Referred) == "numeric"
class(cleaned_data$Informed) == "numeric"
class(cleaned_data$Death_Count) == "numeric"

# Test that date is within the bounds of 2020-11-01 to 2023-06-30
start_date <- as.Date("2020-11-30")
end_date <- as.Date("2023-06-30")
start_date <= cleaned_data$Month_date[1]
end_date >= cleaned_data$Month_date[32]

# Test that dates are chronological
chronological_dates <- list()

for (n in 1:(length(cleaned_helpline$Month_date)-1)) {
  if (cleaned_data$Month_date[[n]] < cleaned_data$Month_date[[n+1]]) {
    chronological_dates[[n]] <- TRUE
  }
  else{
    chronological_dates[[n]] <- FALSE
  }
}
all(chronological_dates == "TRUE")

