devtools::install_github("kassambara/ggcorrplot")
library(ggcorrplot)
library(tidyverse)

# Correlation matrix
fitbit <- read_csv("src/data/apple_watch_fitbit_data.csv")
fitbit_data <- fitbit %>%
    select(age, height, weight, steps, hear_rate, calories, distance, resting_heart)
corr <- round(cor(fitbit_data), 2)

# Plot
p <- corr %>%
    ggcorrplot(
        hc.order = TRUE,
        method = "square", # Try also circle
        type = "lower", # Try also type full and upper
        lab = TRUE,
        lab_size = 4,
        colors = c("#104e8b", "white", "#f13c34"), # Try different colors
        title = "Correlogram of fitbit data",
        ggtheme = theme_light
    )

p

ggsave(
    "ggplot-gallery/assets/img/corrplot.png",
    plot = p,
    width = 7, height = 6, dpi = 150
)

