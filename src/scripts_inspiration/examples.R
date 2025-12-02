# Title     : 3. Tidyverse - examples
# Created by: Jana Dlouha
# Created on: 08.03.2022

# DATASETS
data() # R built-in datasets
# install.packages("babynames")
library(gapminder) # https://www.gapminder.org/data/
data(mtcars)
library(palmerpenguins)

# TIDYVERSE
# https://www.tidyverse.org/


# DPLYR


# GGPLOT2

# Packages
library(tidyverse)
# install.packages("babynames")
library(babynames)
library(viridis)

# Load dataset from github
data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", header=T)
data$date <- as.Date(data$date)

# Load dataset from github
don <- babynames %>%
  filter(name %in% c("Ashley", "Amanda", "Mary", "Deborah",   "Dorothy", "Betty", "Helen", "Jennifer", "Shirley")) %>%
  filter(sex=="F")

# Plot
don %>%
  ggplot( aes(x=year, y=n, group=name, fill=name)) +
    geom_area() +
    scale_fill_viridis(discrete = TRUE) +
    theme(legend.position="none") +
    ggtitle("Popularity of American names in the previous 30 years") +
    theme_light() +
    theme(
      legend.position="none",
      panel.spacing = unit(0, "lines"),
      strip.text.x = element_text(size = 8),
      plot.title = element_text(size=13)
    ) +
    facet_wrap(~name, scale="free_y")
