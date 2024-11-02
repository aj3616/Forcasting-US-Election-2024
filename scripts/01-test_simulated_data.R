#### Preamble ####
# Purpose: Tests the structure and validity of the simulated polling dataset
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(tidyverse)

# Load the simulated dataset
analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the dataset was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# 1. Check if the dataset has 50 rows
if (nrow(analysis_data) == 50) {
  message("Test Passed: The dataset has 50 rows.")
} else {
  stop("Test Failed: The dataset does not have 50 rows.")
}

# 2. Check if the dataset has 15 columns
if (ncol(analysis_data) == 16) {
  message("Test Passed: The dataset has 16 columns.")
} else {
  stop("Test Failed: The dataset does not have 16 columns.")
}

# 3. Check if 'pollster_id' contains only numeric values
if (all(is.numeric(analysis_data$pollster_id))) {
  message("Test Passed: 'pollster_id' contains only numeric values.")
} else {
  stop("Test Failed: 'pollster_id' contains non-numeric values.")
}

# 4. Check if 'sample_size' values are within the expected range (500 to 2000)
if (all(na.omit(analysis_data$sample_size) >= 500 & na.omit(analysis_data$sample_size) <= 2000)) {
  message("Test Passed: 'sample_size' values are within the expected range.")
} else {
  stop("Test Failed: 'sample_size' values are outside the expected range.")
}


# 6. Check if 'population' contains only valid categories
valid_populations <- c("Adults", "Likely Voters", "Registered Voters")
if (all(analysis_data$population %in% valid_populations)) {
  message("Test Passed: 'population' contains only valid categories.")
} else {
  stop("Test Failed: 'population' contains invalid categories.")
}

# 7. Check if 'transparency_score' is between 0 and 10 or NA
if (all(is.na(analysis_data$transparency_score) |
  (analysis_data$transparency_score >= 0 & analysis_data$transparency_score <= 10))) {
  message("Test Passed: 'transparency_score' is between 0 and 10 or NA.")
} else {
  stop("Test Failed: 'transparency_score' is outside the range 0 to 10 or not NA.")
}

# 8. Check if 'cycle' is always 2024
if (all(analysis_data$cycle == 2024)) {
  message("Test Passed: 'cycle' is always 2024.")
} else {
  stop("Test Failed: 'cycle' contains values other than 2024.")
}

# 9. Check if 'candidate_id' contains only numeric values
if (all(is.numeric(analysis_data$candidate_id))) {
  message("Test Passed: 'candidate_id' contains only numeric values.")
} else {
  stop("Test Failed: 'candidate_id' contains non-numeric values.")
}

# 10. Check if there are no missing values in 'pollster', 'sponsors', and 'state'
if (all(!is.na(analysis_data$pollster) & !is.na(analysis_data$sponsors) & !is.na(analysis_data$state))) {
  message("Test Passed: There are no missing values in 'pollster', 'sponsors', or 'state'.")
} else {
  stop("Test Failed: There are missing values in 'pollster', 'sponsors', or 'state'.")
}
