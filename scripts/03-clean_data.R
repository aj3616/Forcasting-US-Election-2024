#### Preamble ####
# Purpose: Cleans the raw US election data
# Author: Amy Jin
# Date: 18 October 2024
# Contact: amyzh.jin@mail.utoronto,ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/president_polls.csv")

# Assuming your data frame is called 'data'



## filter out variables of interests
filtered_data <- raw_data %>%
  select(pollster_id, pollster, state,
         start_date, end_date, sample_size, population, race_id,
         cycle, election_date, candidate_name, pct, pollscore, methodology
         , sponsor_candidate_party)
filtered_data <- data %>%
  filter(candidate_name %in% c("Donald Trump", "Kamala Harris"))
column_types <- sapply(filtered_data, class)
data.frame(Column = names(column_types), Type = column_types)

# TODO: discuss whether to keep NA of states and sample size
na_counts <- filtered_data %>%
  summarise(across(everything(), ~ sum(is.na(.))))

cleaned_data <- filtered_data %>%
  mutate(
    pollster_id = as.numeric(pollster_id), # Ensure pollster_id is numeric
    sample_size = as.numeric(sample_size), # Ensure sample_size is numeric
    race_id = as.numeric(race_id),         # Ensure race_id is numeric
    cycle = as.numeric(cycle),             # Ensure cycle is numeric
    pollscore = as.numeric(pollscore),     # Ensure pollscore is numeric
    pct = as.numeric(pct),                 # Ensure pct is numeric
    
    # Convert character columns to lowercase for consistency and trim whitespace
    pollster = str_trim(tolower(pollster)),
    state = str_trim(tolower(state)),
    population = str_trim(tolower(population)),
    candidate_name = str_trim(tolower(candidate_name)),
    methodology = str_trim(tolower(methodology)),
    sponsor_candidate_party = str_trim(tolower(sponsor_candidate_party))
  )

# View the first few rows of the cleaned data (optional)
head(cleaned_data)

#### Save data ####
write_csv(filtered_data, "data/02-analysis_data/analysis_data.csv")