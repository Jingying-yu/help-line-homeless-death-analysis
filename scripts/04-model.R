#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/cleaned_data.parquet")

### Model data ####
# total_coded_model is a regression model of Death_Count = b_0 + b_1*Total_Coded + eplison
# Total_Coded variable includes the sum of helplines calls coded per month, including calls that are coded as "Reffered" and "Informed"
# Relationship between Total_Coded and "Referred" "Informed" is: Total_Coded = Referred + Informed + others
total_coded_model <-
  stan_glm(
    formula = Death_Count ~ Total_Coded,
    data = cleaned_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 21
  )

# referred_informed_model focuses on the causal relationship between two of the helpline code types: Referred and Informed
referred_informed_model <-
  stan_glm(
    formula = Death_Count ~ Referred + Informed,
    data = cleaned_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 21
  )

#### Save model ####
saveRDS(
  total_coded_model,
  file = "models/total_coded_model.rds"
)

saveRDS(
  referred_informed_model,
  file = "models/referred_informed_model.rds"
)



