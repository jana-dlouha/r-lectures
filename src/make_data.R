# ------------------------------------------------------------------
# Master script for running all dataset preparation pipelines.
# Each source() call executes one self-contained data-preparation script.
# New datasets can be added simply by uncommenting / adding lines below.
# ------------------------------------------------------------------

source("src/data_prep/bfi_traits.R") # BFI personality trait dataset
source("src/data_prep/sat_act.R")     # SAT/ACT scoring example

# Future datasets:
# source("src/data_prep/xyz_dataset.R") # Add more as needed
# ------------------------------------------------------------------