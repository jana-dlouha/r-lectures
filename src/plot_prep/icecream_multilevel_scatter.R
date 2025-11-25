# -------------------------------------------------------------------
# Generate a multi‑group scatterplot (Level 2) for the Ice Cream dataset
# -------------------------------------------------------------------
# This script:
#   • loads the cleaned Ice Cream dataset (prepared in data_prep/)
#   • recodes the flavour variable into a labelled factor
#   • builds a scatterplot of two continuous scores
#   • colours / shapes points by ice‑cream flavour
#   • adds separate regression lines for each flavour
#   • adds group‑wise Pearson correlations
#   • saves the final figure into the gallery assets folder
# -------------------------------------------------------------------

# Load required packages -------------------------------------------------------
library(tidyverse)
library(ggpubr)   # stat_cor() for correlation annotations

# Load prepared dataset --------------------------------------------------------
# Expecting a semicolon‑separated CSV created by src/data_prep/ice_cream.R
icecream <- read_csv("src/data/ice_cream.csv")

# Quick clean + recodes --------------------------------------------------------
icecream <- icecream %>%
  drop_na(video, puzzle, ice_cream) %>%   # keep complete cases for plotted vars
  mutate(
    # Recode ice‑cream flavour into readable labels for plotting
    ice_cream = factor(
      ice_cream,
      levels = c(1, 2, 3),
      labels = c("Vanilla", "Chocolate", "Strawberry")
    ),
    # Optional: keep gender as a labelled factor (not used in this plot yet)
    female = factor(female, levels = c(0, 1), labels = c("Male", "Female"))
  )

# Build the plot ---------------------------------------------------------------
# We plot: video‑game score (x) vs puzzle score (y),
# then split aesthetics by ice‑cream preference.
p <- ggplot(icecream, aes(x = video, y = puzzle)) +

  # Points: colour + shape by flavour
  geom_jitter(aes(color = ice_cream, shape = ice_cream), size = 2, alpha = 0.75) +

  # Group‑wise linear trend lines (no ribbons to keep the plot readable)
  geom_smooth(
    aes(color = ice_cream),
    method = "lm",
    se = FALSE,
    linewidth = 1.1,
    fullrange = TRUE
  ) +

  # Optional rugs: show distributions along axes
  geom_rug(aes(color = ice_cream), alpha = 0.6) +

  # Group‑wise Pearson correlations
  stat_cor(
    aes(color = ice_cream),
    method = "pearson",
    label.x = min(icecream$video) + 5,   # left side
    label.y.npc = "top",
    size = 5,
    show.legend = FALSE
  ) +

  # Labels
  labs(
    x = "Video‑game score",
    y = "Puzzle‑solving score",
    title = "Video‑game vs Puzzle scores by ice‑cream preference",
    color = "Favourite flavour",
    shape = "Favourite flavour"
  ) +

  # Manual palette (kept consistent with your gallery style)
  scale_color_manual(
    values = c("Vanilla" = "#00AFBB", "Chocolate" = "#E7B800", "Strawberry" = "#FC4E07")
  ) +

  # Clean theme for target image
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    legend.position = "top"
  )

# Print plot when running interactively ---------------------------------------
p

# Save final plot --------------------------------------------------------------
ggsave(
  filename = "ggplot-gallery/assets/img/icecream_multilevel_scatter.png",
  plot = p,
  width = 7, height = 6, dpi = 150
)
