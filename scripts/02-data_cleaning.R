#### Preamble ####
# Purpose: Cleans the raw datasets obtained from OpenDataToronto to keep variables of interest for further analysis
# Author: Sandy Yu
# Date: 5 March, 2024
# Contact: jingying.yu@mail.utoronto.ca
# License: MIT
# Pre-requisites: downloaded and save required data and understand what aspects of the datasets are valueable


#### Workspace setup ####
library(tidyverse)
library(lubridate)

#### Clean data ####

## Helpline Dataset ##
raw_helpline <- read_csv("data/raw_data/raw_helpline.csv")

cleaned_helpline <-
  raw_helpline |> 
  # rename desired columns with appropriate names
  rename(Total_Coded = `Total calls coded`, 
         Referred = `Code 1A - Referral to a Sleeping/Resting Space`, 
         Informed = 
           `Code 2C - Information - Homelessness & Prevention Services`) |> 
  # keep only the desired columns for easier computation
  select(Date, Total_Coded, Referred, Informed) |> 
  filter(Date <= "2023-06-30") 

cleaned_helpline <-
  cleaned_helpline |>
  group_by(Month = lubridate::ceiling_date(Date, "month") - 1) |> 
  summarise(Total_Coded = sum(Total_Coded), 
            Referred = sum(Referred), Informed = sum(Informed)) |>
  mutate(Month_date = as.Date(Month))

# We now want to append the homeless death count number onto the helpline dataset
raw_homeless_death <- read_csv("data/raw_data/raw_homeless_death.csv")

cleaned_homeless_death <- raw_homeless_death|> 
  #cleaning up the names of columns to exclude spaces
  rename(Month = `Month of death`) |>
  #filter out Month with "Unknown" value
  filter(!(Month %in% c("Unknown")))

# combine the two datasets
cleaned_data <- 
  cbind(cleaned_helpline, cleaned_homeless_death[-(1:46),]) |>
  select(Month_date, Total_Coded, Referred, Informed, Count) |>
  rename(Death_Count = Count)

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_data.csv")
