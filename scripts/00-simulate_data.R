#### Preamble ####
# Purpose: Simulates a dataset of US elections
# Author: Amy Jin
# Date: 18 October 2024
# Contact: amyzh.jin@mail.utoronto,ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `Forcasting-US-Elections` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(lubridate)

# Simulate a sample dataset
set.seed(123)  # For reproducibility
polling_data <- tibble(
  poll_id = 1:10,
  pollster = c("YouGov", "Ipsos", "SurveyUSA", "Morning Consult", "Quinnipiac", 
               "Emerson College", "Marist College", "Rasmussen Reports", 
               "Fox News", "CNN"),
  sample_size = c(1500, 1200, 800, 1300, 1400, 1100, 1000, 1600, 900, 1250),
  population = c("Likely Voters", "Registered Voters", "Likely Voters", 
                 "Likely Voters", "Registered Voters", "Likely Voters", 
                 "Registered Voters", "Likely Voters", "Likely Voters", 
                 "Registered Voters"),
  candidate_name = rep(c("Kamala Harris", "Donald Trump"), 5),
  pct = c(46, 44, 47, 43, 49, 45, 48, 42, 47, 46)
)

sample_data <- tibble(
  pollster_id = sample(1:100, 50, replace = TRUE),
  pollster = sample(c("Pollster A", "Pollster B", "Pollster C"), 50, replace = TRUE),
  sponsors = sample(c("Sponsor 1", "Sponsor 2", "Sponsor 3"), 50, replace = TRUE),
  transparency_score = sample(c(NA, seq(0, 10, by = 0.5)), 50, replace = TRUE),
  state = sample(c("CA", "TX", "NY", "FL", "PA"), 50, replace = TRUE),
  start_date = sample(seq.Date(from = as.Date("2024-01-01"), to = as.Date("2024-10-01"), by = "day"), 50, replace = TRUE),
  end_date = sample(seq.Date(from = as.Date("2024-01-02"), to = as.Date("2024-10-03"), by = "day"), 50, replace = TRUE),
  sponsor_candidate_party = sample(c("Democratic", "Republican"), 50, replace = TRUE),
  endorsed_candidate_name = sample(c("Candidate A", "Candidate B"), 50, replace = TRUE),
  endorsed_candidate_party = sample(c("Democratic", "Republican"), 50, replace = TRUE),
  sample_size = sample(c(NA, 500:2000), 50, replace = TRUE),
  population = sample(c("Adults", "Likely Voters"), 50, replace = TRUE),
  race_id = sample(1:10, 50, replace = TRUE),
  cycle = rep(2024, 50),
  election_date = rep(as.Date("2024-11-05"), 50),
  candidate_id = sample(100:200, 50, replace = TRUE)
)

# View the simulated data
head(sample_data)


set.seed(853)


#### Simulate data ####
# State names
states <- c(
  "New South Wales",
  "Victoria",
  "Queensland",
  "South Australia",
  "Western Australia",
  "Tasmania",
  "Northern Territory",
  "Australian Capital Territory"
)

# Political parties
parties <- c("Labor", "Liberal", "Greens", "National", "Other")

# Create a dataset by randomly assigning states and parties to divisions
analysis_data <- tibble(
  division = paste("Division", 1:151),  # Add "Division" to make it a character
  state = sample(
    states,
    size = 151,
    replace = TRUE,
    prob = c(0.25, 0.25, 0.15, 0.1, 0.1, 0.1, 0.025, 0.025) # Rough state population distribution
  ),
  party = sample(
    parties,
    size = 151,
    replace = TRUE,
    prob = c(0.40, 0.40, 0.05, 0.1, 0.05) # Rough party distribution
  )
)


#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_data.csv")
