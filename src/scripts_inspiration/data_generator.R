# Use reverse engeneering and give me an R code to create dataset with specific features: Topic is psychology, number of variables it about 30. There are all types of variables: nominal (dichotomous and polytomous), ordinal, metric. There are outliers, missing values, non-normal and skewed distributions, and other problems that can occur in real world data. The data are suitable for using statistical tests as t-test, ANOVA, correlation, logistic regression, linear regression, chi-square test and their nonparametric alternatives.

# Load required packages
library(tidyverse)

# Set the random seed for reproducibility
# set.seed(NULL)

# Generate the dataset
n <- 500 # Number of observations

# Nominal variables
gender <- factor(sample(c("Male", "Female"), n, replace = TRUE))
employment_status <- factor(sample(c("Employed", "Unemployed", "Student", "Retired"), n, replace = TRUE))
race <- factor(sample(c("White", "Black", "Asian", "Hispanic"), n, replace = TRUE))

# Ordinal variables
education_level <- factor(sample(c("No_degree", "High_school", "College", "Masters", "PhD"), n, replace = TRUE), ordered = TRUE)
satisfaction <- factor(sample(1:5, n, replace = TRUE), ordered = TRUE)

# Metric variables
age <- round(rnorm(n, mean = 35, sd = 10))
income <- round(rnorm(n, mean = 50000, sd = 20000))
height <- round(rnorm(n, mean = 170, sd = 10))
weight <- round(rnorm(n, mean = 70, sd = 15))

# Skewed distributions
stress_score <- rexp(n, rate = 0.2)
anxiety_score <- rgamma(n, shape = 2, scale = 1)

# Non-normal distributions
job_satisfaction <- rbeta(n, shape1 = 2, shape2 = 5)
help_seeking <- rbinom(n, size = 10, prob = 0.5)

# Create new variables with outliers and missing values
life_satisfaction <- round(rnorm(n, mean = 7, sd = 1))
life_satisfaction <- life_satisfaction
life_satisfaction[sample(1:n, 5)] <- life_satisfaction[sample(1:n, 5)] + 10

close_friends <- round(rnorm(n, mean = 5, sd = 2))
close_friends_missing <- close_friends
close_friends_missing[sample(1:n, 10)] <- NA


# Create the final dataset
dataset <- data.frame(gender, employment_status, race, education_level, satisfaction, age, income, height, weight, stress_score, anxiety_score, life_satisfaction, close_friends)

# Add new variables to the dataset
dataset$life_satisfaction <- life_satisfaction
dataset$close_friends_missing <- close_friends_missing


# Inspect the dataset
head(dataset)

dataset %>%
    filter(life_satisfaction < 15) %>%
    ggplot(aes(y = life_satisfaction, fill = gender)) +
    geom_boxplot() +
    theme_light()

dataset %>%
    filter(life_satisfaction < 15) %>%
    t.test(life_satisfaction ~ gender, data = .)

 t.test(life_satisfaction ~ gender, data = dataset)
