# -------------------------------------------------------------------
# Generate target image for Scatter + smooth (cars dataset)
# -------------------------------------------------------------------
# This script:
#   • uses the built-in cars dataset (speed vs stopping distance)
#   • builds the final target plot for the ggplot gallery task
#   • saves a PNG into ggplot-gallery/assets/img/
# -------------------------------------------------------------------

# Load packages ---------------------------------------------------------------
library(tidyverse)

# Set a clean default theme for the target image ------------------------------
theme_set(theme_minimal(base_size = 14))

# Build the final target plot ------------------------------------------------
# Mapping: speed → x-axis, dist → y-axis
p <- ggplot(cars, aes(speed, dist)) +

  # Scatter of raw observations
  geom_point(size = 2, alpha = 0.7, color = "black") +

  # LOESS smooth with confidence band
  geom_smooth(method = "loess", se = TRUE, linewidth = 1.2, color = "#2C6BED") +

  # Basic labels
  labs(
    x = "Speed (mph)",
    y = "Stopping distance (ft)",
    title = "Cars: speed and stopping distance"
  ) +

  # Minimal styling tweaks for lecture readability
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

# Save target PNG for the gallery --------------------------------------------
ggsave(
  filename = "ggplot-gallery/assets/img/scatter_smooth.png",
  plot = p,
  width = 6, height = 6, dpi = 150
)

# Print plot when running interactively --------------------------------------
p
