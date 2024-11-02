#### Preamble ####
# Purpose: Reformat R scripts for consistent style and readability
# Author: Amy Jin
# Date: [Update with today's date]
# Contact: amyzh.jin@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `styler` package must be installed and loaded
# Any other information needed? Ensure the specified script files are in the correct directory

#This script is soley for the purpose of reformatting
library(styler)

# Reformat an R script
styler::style_file("scripts/00-simulate_data.R")
styler::style_file("scripts/01-test_simulated_data.R")
styler::style_file("scripts/03-clean_data.R")
styler::style_file("scripts/04-test_analysis_data.R")
styler::style_file("scripts/06-model_data.R")
