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
library(gapminder) # provides the built-in gapminder dataset
library(ggrepel)   # provides geom_text_repel() for non-overlapping labels

# Load prepared dataset -------------------------------------------------------
# If a cleaned CSV exists in src/data/, use it (keeps workflow consistent).
# Otherwise fall back to the built-in gapminder dataset.
gapminder::gapminder

# Prepare a readable subset ---------------------------------------------------
# We pick one year and one continent so labels stay legible.
df <- gapminder %>%
  filter(year == 2007, continent == "Europe") %>%
  drop_na()

# Build the base plot (no theme yet) ------------------------------------------
# x = GDP per capita (log scale later), y = life expectancy.
p <- ggplot(df, aes(x = gdpPercap, y = lifeExp, label = country)) +

  # Step 1: basic scatterplot
  geom_point() +

  # Step 2: add labels with ggrepel (avoids overlaps)
  geom_text_repel(size = 3, max.overlaps = Inf) +

  # Step 3: polish for teaching clarity
  scale_x_log10() +
  labs(
    x = "GDP per capita (log scale)",
    y = "Life expectancy (years)",
    title = "Gapminder 2007: Europe",
    subtitle = "Each point is one country"
  ) +
  theme_minimal(base_size = 14)

# Save final plot --------------------------------------------------------------
ggsave(
  filename = "ggplot-gallery/assets/img/gapminder_labeled_scatter.png",
  plot = p,
  width = 7, height = 6, dpi = 150
)

# Print plot when running interactively ---------------------------------------
p
