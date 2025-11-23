# ---------------------------------------------------------------
# Prepare SAT/ACT dataset for teaching correlation scatterplots
# ---------------------------------------------------------------
# This script:
# - loads the sat.act dataset from the psych package
# - selects core variables used in ggplot teaching examples
# - removes rows with missing values
# - recodes gender into a labelled factor
# - adds a clean sequential id
# - saves a tidy CSV for Quarto tasks and plotting scripts
# ---------------------------------------------------------------

# Load packages
library(tidyverse)
library(psych)

# Load the dataset explicitly from psych
data(sat.act, package = "psych")

# Keep complete cases and standardize variables
df <- sat.act %>%
  select(gender, education, age, ACT, SATV, SATQ) %>%
  drop_na() %>%
  transmute(
    id = row_number(),
    gender = factor(gender, levels = c(1, 2), labels = c("male", "female")),
    education = education, # Self reported education 1 = high school ... 5 = graduate work
    age = age,
    ACT = ACT,
    SATV = SATV,
    SATQ = SATQ
  ) %>%
  as_tibble()

# Export cleaned dataset
write_csv2(df, "src/data/sat_act.csv")
