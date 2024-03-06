#### Preamble ####
# Purpose: Simulates data to predict issues that we may encounter with the real datasets
# Author: Sandy Yu
# Date: 5 March, 2024
# Contact: jingying.yu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: look at sketches file or have a basic understanding of what the data is used for


#### Workspace setup ####
library(tidyverse)
library(ggplot2)

#### Simulate data ####
# Set seed for reproducibility
set.seed(21)

# Create Month_id column
Month_id <- 1:36
# Create Total_coded column with random samples between 100 and 500
Total_coded <- sample(100:500, 36, replace = TRUE)
# Create Referred column with random samples between 0 and 60
Referred <- sample(0:60, 36, replace = TRUE)
# Create Informed column with random samples between 0 and 60
Informed <- sample(0:60, 36, replace = TRUE)
# Generate Death values inversely proportional to the values of the other variables
Death <- 500 - Total_coded/2 - Referred/2 - Informed/2 + rnorm(36, 0, 20)

# Combine all columns into a data frame
simulated_data <- data.frame(Month_id, Total_coded, Referred, Informed, Death)

# Plot Total_coded against Death
ggplot(simulated_data, aes(x = Total_coded, y = Death)) +
  geom_point() +  # Add points
  geom_smooth(method = "lm", se = TRUE) +  # Add linear regression line
  labs(title = "Relationship between Total_coded and Death",
       x = "Total_coded", y = "Death") +  # Set titles for axes
  theme_minimal()  # Set minimal theme



