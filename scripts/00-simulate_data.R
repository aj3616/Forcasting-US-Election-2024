#### Preamble ####
# Purpose: Simulates a dataset of US elections with sample polling data
# Author: Amy Jin
# Date: 18 October 2024
# Contact: amyzh.jin@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse` package must be installed and loaded
#   - Ensure that you are in the `Forcasting-US-Elections` R project directory
#   - The directory "data/00-simulated_data/" must exist for saving the data file
# Any other information needed? 
#   - Run this script to generate and save the simulated dataset


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(lubridate)
library(tibble)

# Set the seed for reproducibility
set.seed(106)

# Simulate polling data
polling_data <- tibble(
  poll_id = 1:10,
  pollster = c("YouGov", "Ipsos", "SurveyUSA", "Morning Consult", "Quinnipiac", 
               "Emerson College", "Marist College", "Rasmussen Reports", 
               "Fox News", "CNN"),
  sample_size = sample(800:1600, 10, replace = TRUE),
  population = sample(c("Likely Voters", "Registered Voters"), 10, replace = TRUE),
  candidate_name = rep(c("Kamala Harris", "Donald Trump"), 5),
  pct = sample(40:60, 10, replace = TRUE)
)

# Simulate sample data
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

#### Save data ####
write_csv(sample_data, "data/00-simulated_data/simulated_data.csv")
