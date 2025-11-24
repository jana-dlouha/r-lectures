# -------------------------------------------------------------------
# Theme showcase: one boxplot, many ggplot2 themes
# -------------------------------------------------------------------
# This script:
#   • loads the prepared BFI dataset
#   • builds one base boxplot (no theme modifications)
#   • applies multiple ggplot2 themes, one by one
#   • saves each themed version as a separate PNG
#   • these PNGs will later be embedded in a Quarto tutorial
# -------------------------------------------------------------------

library(tidyverse)
library(ggpubr)

# Load dataset ---------------------------------------------------------------
df <- read_csv2("src/data/bfi_traits.csv")

# Prepare long-format boxplot dataset ----------------------------------------
plot_data <- df %>%
  gather(trait, score, agree:openness) %>%
  mutate(
    gender = factor(gender, labels = c("Male", "Female"))
  )

# Define a base plot ----------------------------------------------------------
base_plot <- ggplot(plot_data, aes(x = trait, y = score, fill = gender)) +
  geom_boxplot() +
  labs(
    x = "BFI Trait",
    y = "Score",
    title = "BFI scores by gender"
  ) +
  scale_x_discrete(
    labels = c(
      agree = "Agreeable",
      conscientious = "Conscientious",
      extraversion = "Extraversion",
      neuroticism = "Neuroticism",
      openness = "Openness"
    )
  ) +
  scale_fill_manual(
    name = "Gender",
    values = c("#008000", "#800080")
  ) +
  facet_grid(rows = vars(gender))

base_plot

# Save default theme -----------------------------------------------------------
ggsave(
  filename = "ggplot-gallery/assets/img/theme_showcase_bfi.png",
  plot = base_plot,
  width = 7,
  height = 5,
  dpi = 150
)
