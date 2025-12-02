library(gapminder)
library(plotly)
library(tidyverse)

?gapminder

head(gapminder)

plot_ly(
  gapminder,
  x = ~gdpPercap,
  y = ~lifeExp,
  size = ~pop,
  color = ~continent,
  frame = ~year,
  text = ~paste(
    "Country:", country,
    "<br>Life expectancy:", lifeExp,
    "<br>GDP per capita:", round(gdpPercap),
    "<br>Population:", format(pop, scientific = FALSE)
  ),
  hoverinfo = "text",
  sizes = c(5, 80),
  type = "scatter",
  mode = "markers",
  colors = c("#EE4244FF", "#F8D961FF", "#B6D944FF", "#638E6EFF", "#3C5541FF", "#132157FF"),
  marker = list(opacity = 0.7, sizemode = "diameter")
) %>%
  layout(
    title = "Global Development Over Time",
    xaxis = list(title = "GDP per capita", type = "log"),
    yaxis = list(title = "Life expectancy"),
    legend = list(title = list(text = "<b>Continent</b>"))
  )


