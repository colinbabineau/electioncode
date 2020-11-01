#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
#install.packages("tidyverse")
#install.packages("haven")
library(haven)
library(tidyverse)
setwd("C:/users/colin/Desktop/ps3")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(vote_2016,
         vote_2020,
         race_ethnicity,
         state,
         age,
         gender)

#last six are new

#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0))

reduced_data <-
  reduced_data %>%
  mutate(sex_male = 
           ifelse(gender == "Male", 1, 0))

reduced_data <-
  reduced_data %>%
  mutate(blue_state = 
           ifelse(state == "CA" | state == "CT" | state == "HI" | state == "IL" |
                    state == "ME" | state == "MD" | state == "MA" | state == "MI" | state == "MN" |
                    state == "NJ" | state == "NY" | state == "OR" | state == "RI" |
                    state == "DC" | state == "VT" | state == "WA", 1, 0))

reduced_data <-
  reduced_data %>%
  mutate(is_white = 
           ifelse(race_ethnicity == "White", 1, 0))

reduced_data <-
  reduced_data %>%
  filter(vote_2020 == "Joe Biden" | vote_2020 == "Donald Trump")

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "C:/Users/colin/Desktop/ps3/election_survey.csv")


