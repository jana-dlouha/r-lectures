# -------------------------------------------------------------------
# Generate correlation scatterplot for SAT Verbal vs SAT Quantitative
# -------------------------------------------------------------------
# This script:
#   • loads the cleaned SAT/ACT dataset created in data_prep/
#   • builds a clear scatterplot with regression line
#   • adds a readable Pearson correlation annotation
#   • applies a minimal theme suitable for teaching examples
#   • saves the final figure into the gallery assets folder
# -------------------------------------------------------------------

# Load required packages -------------------------------------------------------
library(tidyverse)
library(ggpubr)   # provides stat_cor() for easy correlation annotation

# Load prepared dataset --------------------------------------------------------
# CSV was created earlier by src/data_prep/sat_act.R
df <- read_csv2("src/data/sat_act.csv")

# Build the plot ---------------------------------------------------------------
# Start with basic aesthetics: SATV (verbal) → x-axis, SATQ (quantitative) → y-axis
p <- ggplot(df, aes(SATV, SATQ)) +
  
  # Raw points: no colour or size styling (students add this later)
  geom_point() +
  
  # Add linear regression trend line with confidence band
  geom_smooth(method = "lm", se = TRUE, linewidth = 1.1) +
  
  # Correlation annotation (Pearson), placed on left side of the plot
  # size = 6 ensures visibility when shown on slides
  stat_cor(
    method = "pearson",
    label.x = 200,
    size = 6
  ) +
  
  # Basic labels — title + axis labels
  labs(
    x = "SAT Verbal",
    y = "SAT Quantitative",
    title = "SAT Verbal vs SAT Quantitative"
  ) +
  
  # Minimal base theme for clarity
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),  # bold title looks more “lecture-ready”
    panel.grid.minor = element_blank()         # removes noisy minor gridlines
  )

# Save final plot --------------------------------------------------------------
# Saved into the gallery asset folder (PNG), ready to be used as target image
ggsave(
  filename = "ggplot-gallery/assets/img/scatter_correlation_sat_act.png",
  plot = p,
  width = 6, height = 6, dpi = 150
)

# Print plot when running interactively ----------------------------------------
p