## ----------------------------------
## Tufte's principles of graphical excellance
## ----------------------------------
library(tidyverse)
library(gapminder)
data(gapminder)


# -----------------------------------------------------------------------------------------
# Principle 1) Proportionality principle
# -----------------------------------------------------------------------------------------

# Wrong
gapminder %>%
    filter(country == "Peru", year < 1980) %>%
    ggplot(aes(x = year, y = lifeExp, fill = as.factor(year))) +
        geom_col() +
        theme_light() +
        theme(legend.position = "none") +
        coord_cartesian(ylim = c(43.9, 60)) +
        geom_hline(yintercept = 43.9, color = "red", size = 2) +
        geom_hline(yintercept = 58.45, color = "red", size = 2) +
        geom_label(aes(x = 1960, y = 58.45, fill = NULL), label = "Ratio is about 14.6", size = 10)

# Good
gapminder %>%
    filter(country == "Peru", year < 1980) %>%
    ggplot(aes(x = year, y = lifeExp, fill = as.factor(year))) +
        geom_col() +
        theme_light() +
        theme(legend.position = "none") +
        coord_cartesian(ylim = c(0, 60)) +
        geom_hline(yintercept = 43.9, color = "red", size = 2) +
        geom_hline(yintercept = 58.45, color = "red", size = 2) +
        geom_label(aes(x = 1960, y = 58.45, fill = NULL), label = "Ratio is about 1.3", size = 10)

(max_life_exp <- gapminder %>% filter(country == "Peru", year < 1980) %>% slice_max(lifeExp))
(min_life_exp <- gapminder %>% filter(country == "Peru", year < 1980) %>% slice_min(lifeExp))

max_life_exp$lifeExp / min_life_exp$lifeExp



# -----------------------------------------------------------------------------------------
# Principle 2) Maximize data-to-ink ratio
# -----------------------------------------------------------------------------------------

# Wrong
gapminder %>%
    filter(country == "Peru", year < 1980) %>%
    ggplot(aes(x = year, y = lifeExp, fill = as.factor(year))) +
        geom_col() +
        theme(
            panel.grid.major = element_line(size = 1, linetype = 'dashed', colour = "green"),
            panel.grid.minor = element_line(size = 1, linetype = 'dashed', colour = "blue"),
            panel.background = element_rect(fill = "red", colour = "blue"),
            plot.background = element_rect(fill = "green")
        )

# Better
gapminder %>%
    filter(country == "Peru", year < 1980) %>%
    ggplot(aes(x = year, y = lifeExp, fill = as.factor(year))) +
        geom_col() +
        theme_light() +
        theme(legend.position = "none")

# Also very good
gapminder %>%
    filter(country == "Peru", year < 1980) %>%
    ggplot(aes(x = year, y = lifeExp, fill = (year == 1967))) +
        geom_col() +
        theme_minimal() +
        theme(
            axis.text.y = element_blank(),
            legend.position = "none") +
    scale_fill_manual(values = c("gray", "red")) +
    geom_text(
    aes(x = year, y = lifeExp, label = round(lifeExp)), nudge_y = 0.25, size = 7, vjust = 2, color = "black")



# Colorblind friendly colors https://davidmathlogic.com/colorblind/#%23D81B60-%231E88E5-%23FFC107-%23004D40

