#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("C:/users/colin/Desktop/ps3")
# Read in the raw data.
raw_data2 <- read_dta("usa_00001 (1).dta.gz")


# Add the labels
raw_data2 <- labelled::to_factor(raw_data2)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data2 <- 
  raw_data2 %>% 
  select(sex, 
         age,
         stateicp,
         race)
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data2 <-
  reduced_data2 %>%
  mutate(sex_male = 
           ifelse(sex == "male", 1, 0))

reduced_data2 <-
  reduced_data2 %>%
  mutate(is_white =
           ifelse(race == "white", 1 , 0))

reduced_data2 <-
  reduced_data2 %>%
  mutate(blue_state = 
           ifelse(stateicp == "california" | stateicp == "connecticut" | 
                    stateicp == "hawaii" | stateicp == "illinois" |
                    stateicp == "maine" | stateicp == "maryland" | 
                    stateicp == "massachusetts" | stateicp == "michigan" |
                    stateicp == "minnesota" |stateicp == "new jersey" | 
                    stateicp == "new york" |stateicp == "oregon" | 
                    stateicp == "rhode island" |stateicp == "district of columbia" | 
                    stateicp == "vermont" | stateicp == "washington", 1, 0))


reduced_data2 <- 
  reduced_data2 %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")



reduced_data2$age <- as.integer(reduced_data2$age)

reduced_data2 <- 
  reduced_data2 %>%
  count(age, sex_male, blue_state, is_white) %>%
  group_by(age, sex_male, blue_state, is_white) 



# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data2, "C:/Users/colin/Desktop/ps3/census_data.csv")



         