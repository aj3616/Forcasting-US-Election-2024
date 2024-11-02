#### Preamble ####
# Purpose: Validate the structure and content of the simulated polling dataset
# Author: Amy Jin
# Date: 18 October 2024
# Contact: amyzh.jin@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse`, `testthat`, `arrow`, and `here` packages must be installed and loaded
# - The dataset file "analysis_data.parquet" should be located in the "data/02-analysis_data" directory
# Any other information needed? Make sure you are in the correct project directory before running the script



#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(here)
analysis_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))


#### Preamble ####
# Purpose: Tests simulation and analysis data
# Author: Amy Jin
# Date: 18 October 2024
# Contact: amyzh.jin@mail.utoronto,ca
# License: MIT
# Pre-requisites: tidyverse, testthat, arrow, and here packages installed
# Any other information needed? Make sure the data file is in the correct directory


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(here)

# Load the data
analysis_data <- read_parquet(here::here("data/02-analysis_data/analysis_data.parquet"))

#### Test data ####

# 1. Test if the data was loaded successfully
test_that("Dataset loads correctly", {
  expect_true(exists("analysis_data"))
})

# 2. Test if the data has rows
test_that("Dataset has rows", {
  expect_gt(nrow(analysis_data), 0)
})

# 3. Test if the data has columns
test_that("Dataset has columns", {
  expect_gt(ncol(analysis_data), 0)
})

# 4. Test if there are no missing values in essential columns
test_that("No missing values in essential columns", {
  essential_cols <- c("pollster_id", "pollster", "state", "start_date", "end_date", "sample_size")
  expect_true(all(!is.na(analysis_data[, essential_cols])))
})

# 5. Test if `sample_size` is always greater than zero
test_that("Sample size is positive", {
  expect_true(all(analysis_data$sample_size > 0))
})

# 6. Test if `start_date` is before `end_date`
test_that("Start date is before end date", {
  expect_true(all(as.Date(analysis_data$start_date) < as.Date(analysis_data$end_date)))
})

# 7. Test if `pct` values are between 0 and 100
test_that("Percentages are between 0 and 100", {
  expect_true(all(analysis_data$pct >= 0 & analysis_data$pct <= 100))
})

# 8. Test if `pollscore` is numeric and has finite values
test_that("Pollscore is numeric and finite", {
  expect_true(is.numeric(analysis_data$pollscore))
  expect_true(all(is.finite(analysis_data$pollscore), na.rm = TRUE))
})

# 9. Test if `reliability` only contains valid values
test_that("Reliability contains valid values", {
  valid_reliabilities <- c("Low", "Medium", "High", NA)
  expect_true(all(analysis_data$reliability %in% valid_reliabilities))
})

# 10. Test if `methodology` is a non-empty string
test_that("Methodology is a non-empty string", {
  expect_true(all(nchar(trimws(analysis_data$methodology)) > 0, na.rm = TRUE))
})
