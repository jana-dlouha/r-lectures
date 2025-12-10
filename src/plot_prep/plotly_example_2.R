library(plotly)

data <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/school_earnings.csv")

data$State <- as.factor(c('Massachusetts', 'California', 'Massachusetts', 'Pennsylvania',
                          'New Jersey', 'Illinois', 'Washington DC', 'Massachusetts', 'Connecticut',
                          'New York', 'North Carolina', 'New Hampshire', 'New York', 'Indiana',
                          'New York', 'Michigan', 'Rhode Island', 'California', 'Georgia',
                          'California', 'California'
))

data <- head(data, n = 12)

fig <- plot_ly(data, x = ~Women, y = ~Men, text = ~School, type = 'scatter',
               mode = 'markers', size = ~Gap, color = ~State, colors = 'Paired',
               #Choosing the range of the bubbles' sizes:
               sizes = c(10, 50),
               marker = list(opacity = 0.5, sizemode = 'diameter')
)

fig <- fig %>% layout(title = 'Gender Gap in Earnings per University',
                      xaxis = list(showgrid = FALSE),
                      yaxis = list(showgrid = FALSE),
                      showlegend = FALSE)

fig
