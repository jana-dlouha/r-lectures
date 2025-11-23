# ---------------------------------------------------------------
# Prepare BFI Big Five dataset with computed trait scores
# ---------------------------------------------------------------
# This script:
# 1) loads the raw BFI questionnaire data from the psych package
# 2) computes Big Five trait scores using scoring keys
# 3) merges the scores with demographic variables
# 4) outputs a clean dataset suitable for teaching and plotting
# ---------------------------------------------------------------

# Load packages (no printed output in Quarto)
library(tidyverse)
library(psych)

# Load base dataset and its dictionary
data(bfi, package = "psych")
data(bfi.dictionary, package = "psych")

# ---------------------------------------------------------------
# 1. Define scoring keys for the Big Five traits
# ---------------------------------------------------------------
# Minus signs indicate reverse-keyed items.
keys.list <- list(
  agree         = c("-A1","A2","A3","A4","A5"),
  conscientious = c("C1","C2","C3","-C4","-C5"),
  extraversion  = c("-E1","-E2","E3","E4","E5"),
  neuroticism   = c("N1","N2","N3","N4","N5"),
  openness      = c("O1","-O2","O3","O4","-O5")
)

# ---------------------------------------------------------------
# 2. Prepare demographic variables
# ---------------------------------------------------------------
# We create a clean ID variable (1:n),
# recode gender and education into labelled factors,
# and keep age as numeric.
demographics <- bfi %>%
  transmute(
    id = row_number(),   # sequential ID for merging later
    gender = factor(gender, levels = c(1, 2), labels = c("male", "female")),
    education = factor(
      education,
      levels = 1:5,
      labels = c("in HS", "fin HS", "coll", "coll grad", "grad deg"),
      ordered = TRUE
    ),
    age = age
  ) %>%
  as_tibble()

# ---------------------------------------------------------------
# 3. Compute Big Five trait scores using scoreItems()
# ---------------------------------------------------------------
# scoreItems() returns a list; `$scores` is the data frame of trait scores.
# Important: We add the same `id = row_number()` for merging.
scores_orig <- scoreItems(keys.list, bfi, min = 1, max = 6)$scores %>%
  as_tibble() %>%
  mutate(id = row_number()) %>%     # ID must match the ordering in demographics
  select(id, everything())          # Put id first for clarity

# ---------------------------------------------------------------
# 4. Merge demographic info with computed trait scores
# ---------------------------------------------------------------
scores <- demographics %>%
  left_join(scores_orig, by = "id") %>%
  drop_na()   # remove missing cases (some participants have NA on many items)

# ---------------------------------------------------------------
# 5. Save dataset to CSV
# ---------------------------------------------------------------
# CSV2 = uses semicolon as separator (friendly for Europe).
write_csv2(scores, "src/data/bfi_traits.csv")

# If running interactively, you can inspect:
# if (interactive()) glimpse(scores)