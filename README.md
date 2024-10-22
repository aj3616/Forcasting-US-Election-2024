# US Presidential Election Forecasting Model

## Overview

This project uses r scripts and data from https://projects.fivethirtyeight.com/polls/president-general/2024/national/ to build a linear or generalized linear model to forecast the winner of the upcoming US presidential election. We use the “poll-of-polls” approach (Blumenthal 2014; Pasek 2015) to aggregate polling data and implement the model in an entirely reproducible manner. This project adheres to the principles of open science and transparency, ensuring that every step of the analysis is accessible and repeatable. The result will be generated in the form of pdf produced by quarto. The structure of the project was based on <https://github.com/RohanAlexander/starter_folder>. All simulations and sample used a seed: TODO.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained as well as simulated data created by `scripts/00-simulate_data.R`.
-   `data/analysis_data` contains the cleaned data set that was constructed by `scripts/02-data_cleaning.R`.
-   `other` contains details about LLM chat interactions supporting this project, and sketches for the process of developing this project.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download, clean data and test data.
-   An R project `USElectionForecast.Rproj` is used.
-   All R codes are styled using styler in `scripts/code_style.R`.

## Getting Started

### Prerequisites
R and Required libraries (see requirements.txt for equivalent R libraries):
tidyverse, glmnet, ggplot2 for R
###Setup
Clone the repository:
```
git https://github.com/aj3616/Forcasting-US-Elections
cd Forcasting-US-Election
```

Poll Aggregation
We use the “poll-of-polls” approach to combine results from various polls, smoothing out biases and reducing variance. We selected a single pollster for deep analysis, examining their methodology to assess strengths and weaknesses.

Model Building
We built a linear (or generalized linear) regression model to predict the election outcome based on aggregated polling data. The model takes into account several predictors, including:

TODO:


Reproducibility:
All scripts, data processing steps, and model building procedures are documented and automated to ensure full reproducibility.
Each step is tracked through r scripts within the `scripts/` folders.
Results:

The detailed analysis and results of the model are available in the paper/ directory. The paper provides insights into the model's performance, evaluation metrics, and potential biases or limitations.

Appendices TODO:

Appendix 1: Pollster Methodology Deep Dive
A deep dive into the methodology of the chosen pollster, covering:

Population, Frame, and Sample: Details about the target population and sampling frame.
Sample Recruitment: How the pollster recruits participants and the trade-offs involved.
Sampling Approach: An evaluation of the sampling method and associated biases.
Non-response Handling: Methods used to address non-response issues.
Questionnaire Assessment: Strengths and weaknesses of the pollster's questionnaire.
Appendix 2: Idealized Survey Design
If tasked with forecasting the US presidential election with a $100K budget, we designed an idealized survey. The appendix includes:

Sampling Approach: Detailed explanation of the sampling strategy, respondent recruitment, and validation techniques.
Survey Platform: A link to the Google Form used for the survey and a copy of the survey included in the appendix.
Poll Aggregation: Strategy for aggregating data from multiple surveys to improve reliability and accuracy.
Link to Survey TODO

### License

This project is licensed under the MIT License. See the LICENSE file for more details. TODO:

### Acknowledgments

Special thanks to:

Blumenthal (2014) and Pasek (2015) for the “poll-of-polls” methodology.
Polling organizations for providing accessible data and Rohan Alexander for instructions and templates.


## Statement on LLM usage

Some code for data analysis and sentence phrasings had assistance from ChatGPT 4.0. The prompts and outputs were documented along with the entire chat history in `other/llm/usage.txt`.
