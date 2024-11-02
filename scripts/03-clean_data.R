#### Preamble ####
# Purpose: Clean the variables so that the data focuses on donald trump and the variables of interest for further analysis and model building
# Author: Amy Jin
# Date: 27 October 2024
# Contact: amyzh.jin@mail.utoronto.ca
# License: MIT
# Pre-requisites: raw data in the correct directory and corret file name that has the required varibles
# Assumption: These varibles are workable for data analysis and contributes to model building

#### Workspace setup and loading data  ####

library(tidyverse)
library(janitor)
library(arrow)#for parquet

# Load the raw polling data
raw_data <- read_csv("data/01-raw_data/president_polls.csv")|>
  clean_names()


#### Data Cleaning ####
raw_data <- raw_data %>%
  mutate(is_national = if_else(is.na(state), 1, 0))  # Create binary for national polls


# Filter data to Harris estimates based on high-quality polls after she declared
filtered_data <- raw_data |>
  filter(
    candidate_name == "Donald Trump",
    numeric_grade >= 2.5 
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state),
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2024-07-21")) |> # When Harris declared
  mutate(
    num_trump = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  )


# Select relevant columns for analysis
filtered_data <- filtered_data %>%
  select(pollster_id, pollster, state,
         start_date, end_date, sample_size, population, race_id,
         cycle, election_date, candidate_name, pct, numeric_grade, methodology
         , num_trump, is_national)
na_counts <- filtered_data %>%
  summarise(across(everything(), ~ sum(is.na(.))))
filtered_data <- filtered_data %>%
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



# Ensure 'start_date' and 'end_date' are in date format
filtered_data <- filtered_data %>%
  mutate(
    start_date = parse_date_time(start_date, orders = c("mdy", "ymd")),
    end_date = parse_date_time(end_date, orders = c("mdy", "ymd"))
  )

# Clean the column names
filtered_data <- filtered_data %>%
  clean_names()

# Convert 'end_date' to Date format
filtered_data$end_date <- as.Date(filtered_data$end_date)

# Remove polls from pollsters with fewer than 5 entries
filtered_data <- filtered_data %>%
  group_by(pollster) %>%
  filter(n() >= 5) %>%
  ungroup()
#### Plot data ####
base_plot <- ggplot(just_harris_high_quality, aes(x = end_date, y = pct)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date")

# Plots poll estimates and overall smoothing
base_plot +
  geom_point() +
  geom_smooth()

# Color by pollster
# This gets messy - need to add a filter - see line 21
base_plot +
  geom_point(aes(color = pollster)) +
  geom_smooth() +
  theme(legend.position = "bottom")

# Facet by pollster
# Make the line 21 issue obvious
# Also - is there duplication???? Need to go back and check
base_plot +
  geom_point() +
  geom_smooth() +
  facet_wrap(vars(pollster))

# Color by pollscore
base_plot +
  geom_point(aes(color = factor(pollscore))) +
  geom_smooth() +
  theme(legend.position = "bottom")

#### Save cleaned data ####

write_parquet(filtered_data, "data/02-analysis_data/analysis_data.parquet")

raw_data <- read_csv("data/01-raw_data/president_polls.csv")|>
  clean_names()


#### Data Cleaning ####
raw_data <- raw_data %>%
  mutate(is_national = if_else(is.na(state), 1, 0))  # Create binary for national polls


# Filter data to Harris estimates based on high-quality polls after she declared
filtered_data <- raw_data |>
  filter(
    candidate_name == "Kamala Harris",
    numeric_grade >= 2.5 
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state),
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2024-07-21")) |> # When Harris declared
  mutate(
    num_trump = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  )


# Select relevant columns for analysis
filtered_data <- filtered_data %>%
  select(pollster_id, pollster, state,
         start_date, end_date, sample_size, population, race_id,
         cycle, election_date, candidate_name, pct, numeric_grade, methodology
         , num_trump, is_national)
na_counts <- filtered_data %>%
  summarise(across(everything(), ~ sum(is.na(.))))
filtered_data <- filtered_data %>%
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



# Ensure 'start_date' and 'end_date' are in date format
filtered_data <- filtered_data %>%
  mutate(
    start_date = parse_date_time(start_date, orders = c("mdy", "ymd")),
    end_date = parse_date_time(end_date, orders = c("mdy", "ymd"))
  )

# Clean the column names
filtered_data <- filtered_data %>%
  clean_names()

# Convert 'end_date' to Date format
filtered_data$end_date <- as.Date(filtered_data$end_date)

# Remove polls from pollsters with fewer than 5 entries
filtered_data <- filtered_data %>%
  group_by(pollster) %>%
  filter(n() >= 5) %>%
  ungroup()


#### Save cleaned data ####

write_parquet(filtered_data, "data/02-analysis_data/harris_data.parquet")

