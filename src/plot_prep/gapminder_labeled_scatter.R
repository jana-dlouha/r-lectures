# -------------------------------------------------------------------
# Generate labelled scatterplot from Gapminder (ggrepel showcase)
# -------------------------------------------------------------------
# This script:
#   • loads the Gapminder dataset (prefers prepared CSV if available)
#   • filters to a readable subset (Europe, year 2007)
#   • builds a scatterplot of GDP per capita vs. life expectancy
#   • adds country labels using ggrepel
#   • applies a clean minimal theme
#   • saves the final PNG into the gallery assets folder
# -------------------------------------------------------------------

# Load packages ---------------------------------------------------------------
library(tidyverse)
library(ggrepel)   # provides geom_text_repel() for non-overlapping labels

df <- read_csv2("src/data/gapminder_extended.csv")

# Build the base plot (no theme yet) ------------------------------------------
# x = GDP per capita (log scale later), y = life expectancy.
# Color - try color by language_group, region_europe, econ_block
p <- ggplot(df, aes(x = gdpPercap, y = lifeExp, label = country, color = region_europe)) +

  # Step 1: basic scatterplot
  geom_point() +

  # Step 2: add labels with ggrepel (avoids overlaps)
  geom_label_repel(size = 4, max.overlaps = Inf) +

  # Step 3: polish for teaching clarity
  scale_x_log10() +
  labs(
    x = "GDP per capita (log scale)",
    y = "Life expectancy (years)",
    title = "Gapminder 2007: Europe",
    subtitle = "Each point is one country"
  ) +
  theme_minimal(base_size = 14) +
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#7D3C98", "#3C3C3C"))

# Save final plot --------------------------------------------------------------
ggsave(
  filename = "ggplot-gallery/assets/img/gapminder_labeled_scatter.png",
  plot = p,
  width = 7, height = 6, dpi = 150
)

# Print plot when running interactively ---------------------------------------
p
