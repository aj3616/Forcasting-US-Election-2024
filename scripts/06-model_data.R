#### Preamble ####
# Purpose: Create, compare, and select the best model to predict the 2024 US election result using different modeling approaches
# Author: Amy Jin
# Date: 2024.11.02
# Contact: amyzh.jin@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - Ensure the `tidyverse`, `rstanarm`, `broom`, and `ggplot2` packages are installed and loaded
# - Ensure the data files "analysis_data.parquet" and "harris_data.parquet" are located in the "data/02-analysis_data" directory
# - Make sure you are in the correct project directory before running the script
# Any other information needed? The script uses Bayesian modeling and compares models using AIC/BIC metrics


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(broom)
library(ggplot2)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Define models ####

# Model 1: pct as a function of end_date (time trend only)
model_date <- lm(pct ~ end_date, data = analysis_data)

# Model 2: pct as a function of end_date and pollster (time trend + pollster effect)
model_date_pollster <- lm(pct ~ end_date + pollster, data = analysis_data)

# Model 3: pct as a function of end_date, pollster, and is_national (includes national vs. state poll effect)
model_date_pollster_national <- lm(pct ~ end_date + pollster + is_national, data = analysis_data)

# Model 4: Bayesian model using rstanarm
model_bayesian <- stan_glm(pct ~ end_date + pollster + is_national,
                           data = analysis_data,
                           family = gaussian,
                           prior = normal(0, 5),
                           chains = 4, iter = 2000)

#### Compare models ####
# Calculate AIC and BIC for model comparison
model_comparison <- tibble(
  Model = c("model_date", "model_date_pollster", "model_date_pollster_national"),
  AIC = c(AIC(model_date), AIC(model_date_pollster), AIC(model_date_pollster_national)),
  BIC = c(BIC(model_date), BIC(model_date_pollster), BIC(model_date_pollster_national))
)

# Print the model comparison table
print("Model Comparison Table:")
print(model_comparison)



#### Select the best model ####
# Based on AIC/BIC or cross-validation results, we select the best model
best_model <- model_date_pollster 

#### Use the best model to predict the winner ####
# Get predictions for pct using the best model
analysis_data <- analysis_data %>%
  mutate(final_prediction = predict(best_model))

# Aggregate predictions by candidate to get the overall predicted support
final_results <- analysis_data %>%
  group_by(candidate_name) %>%
  summarise(predicted_support = mean(final_prediction, na.rm = TRUE)) %>%
  arrange(desc(predicted_support))

# Print the final predicted results
print("Final Predicted Results:")
print(final_results)

#### Save the best model ####
saveRDS(best_model, file = "models/best_model.rds")



harris_data <- read_parquet("data/02-analysis_data/harris_data.parquet")

#### Define models ####

# Model 1: pct as a function of end_date (time trend only)
model_date <- lm(pct ~ end_date, data = harris_data)

# Model 2: pct as a function of end_date and pollster (time trend + pollster effect)
model_date_pollster <- lm(pct ~ end_date + pollster, data = harris_data)

# Model 3: pct as a function of end_date, pollster, and is_national (includes national vs. state poll effect)
model_date_pollster_national <- lm(pct ~ end_date + pollster + is_national, data = harris_data)

# Model 4: Bayesian model using rstanarm
model_bayesian <- stan_glm(pct ~ end_date + pollster + is_national,
                           data = harris_data,
                           family = gaussian,
                           prior = normal(0, 5),
                           chains = 4, iter = 2000)

#### Compare models ####
# Calculate AIC and BIC for model comparison
model_comparison <- tibble(
  Model = c("model_date", "model_date_pollster", "model_date_pollster_national"),
  AIC = c(AIC(model_date), AIC(model_date_pollster), AIC(model_date_pollster_national)),
  BIC = c(BIC(model_date), BIC(model_date_pollster), BIC(model_date_pollster_national))
)

# Print the model comparison table
print("Model Comparison Table:")
print(model_comparison)



#### Select the best model ####
# Based on AIC/BIC or cross-validation results, we select the best model
best_model <- model_date_pollster 

#### Use the best model to predict the winner ####
# Get predictions for pct using the best model
harris_data <- harris_data %>%
  mutate(final_prediction = predict(best_model))

# Aggregate predictions by candidate to get the overall predicted support
final_results <- harris_data %>%
  group_by(candidate_name) %>%
  summarise(predicted_support = mean(final_prediction, na.rm = TRUE)) %>%
  arrange(desc(predicted_support))

# Print the final predicted results
print("Final Predicted Results:")
print(final_results)

#### Save the best model ####
saveRDS(best_model, file = "models/harris_model.rds")

