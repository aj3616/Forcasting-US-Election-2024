#This script is soley for the purpose of reformatting
library(styler)

# Reformat an R script
styler::style_file("scripts/00-simulate_data.R")
styler::style_file("scripts/01-test_simulated_data.R")
styler::style_file("scripts/03-clean_data.R")
styler::style_file("scripts/04-test_analysis_data.R")
styler::style_file("scripts/06-model_data.R")