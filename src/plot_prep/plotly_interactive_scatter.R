library(reshape2)
# ----------
# Older package providing tools for reshaping data (melt / cast).
# Still useful for certain legacy workflows and for quickly converting
# wide ↔ long formats when tidyverse equivalents would require more steps.

library(plotly)
# ----------
# Main engine for interactive graphs.
# Takes outputs from ggplot2 or raw data and turns them into HTML widgets
# with zooming, panning, hover labels, and animation support.
# Core tool for the interactive visualisations in this project.

library(kernlab)
# ----------
# Provides kernel-based machine learning methods (SVMs, kernel PCA, Gaussian processes).
# Included here because some visualisations (e.g., decision boundaries)
# rely on kernlab’s modelling functions to generate non-linear surfaces.

library(pracma)
# ----------
# Numerical methods for matrix operations, calculus, interpolation, and 3D surface grids.
# meshgrid() comes from this package and is essential for building
# 3D prediction surfaces that are later plotted using plotly (e.g., 3D contours or surfaces).

library(tidymodels)
# ----------
# Unified set of packages for modelling and machine learning in R.
# Not strictly required for plotly graphics themselves, but useful when
# generating predictions, fits, or more complex model-based surfaces that
# are later visualised interactively.

library(tidyverse)
# ----------
# Modern data manipulation and visualization suite (dplyr, tidyr, ggplot2, readr, etc.).
# Used here mainly for data wrangling, piping (%>%), and clean plotting structures.
# Provides a consistent grammar for transforming and preparing data before plotting.

data(iris)
# ----------
# Classic toy dataset shipped with R.
# Convenient for demonstrating classification boundaries, 3D surfaces,
# and other model-based visualisations in a lightweight format.




# Define the resolution of the prediction grid.
# Smaller mesh_size = smoother surface but heavier computation.
# mesh_size will later be used to build a 2D grid over the Sepal.Width × Sepal.Length space.
# That grid is needed to generate a full prediction surface that plotly can render in 3D.
mesh_size <- 0.02

# No extra padding around the range of the data.
margin <- 0

# Select predictor variables (features) for the model.
X <- iris %>% select(Sepal.Width, Sepal.Length)

# Select the outcome variable we want to predict.
y <- iris %>% select(Petal.Width)

# Fit a radial-basis-function Support Vector Regression model (SVR)
# using kernlab's engine. The model learns how Petal.Width changes
# as a smooth, non-linear function of Sepal.Width and Sepal.Length.
model <- svm_rbf(cost = 1.0) %>% # creates a nonlinear regression model capable of producing smooth curved surfaces. Perfect for visually appealing 3D plots.
  set_engine("kernlab") %>% # ensures compatibility with RBF kernels (Gaussian kernels) and smooth fits.
  set_mode("regression") %>%
  fit(Petal.Width ~ Sepal.Width + Sepal.Length, data = iris)

# Determine the range of the predictor space.
# We find the minimum and maximum values of both predictors
# (Sepal.Width and Sepal.Length). The margin is kept at 0, so
# the grid will tightly match the data range.

x_min <- min(X$Sepal.Width)  - margin
x_max <- max(X$Sepal.Width)  - margin
y_min <- min(X$Sepal.Length) - margin
y_max <- max(X$Sepal.Length) - margin

# Create sequences (x-range and y-range) with the chosen resolution.
# mesh_size controls how dense the prediction grid is.
# Smaller mesh_size = smoother prediction surface, more computation.

xrange <- seq(x_min, x_max, mesh_size)
yrange <- seq(y_min, y_max, mesh_size)

# Create a full 2D grid of coordinates.
# meshgrid() takes the two sequences and expands them into
# all combinations of x and y. This produces matrices:
#   xx = grid of Sepal.Width values
#   yy = grid of Sepal.Length values
# Each cell in xx and yy is a coordinate where we will run predictions.

xy <- meshgrid(x = xrange, y = yrange)
xx <- xy$X
yy <- xy$Y

# Store the original grid dimensions.
# We need these later to reshape the predictions back into a matrix.
dim_val <- dim(xx)

# Flatten the xx and yy matrices into long column vectors.
# The SVR model expects its inputs as rows of (Sepal.Width, Sepal.Length),
# not as 2D matrices.
xx1 <- matrix(xx, length(xx), 1)
yy1 <- matrix(yy, length(yy), 1)

# Combine the flattened coordinates into a single two-column matrix.
# Each row = one (Sepal.Width, Sepal.Length) point where the model predicts Petal.Width.
final <- cbind(xx1, yy1)

# Generate predictions from the SVR model for all grid points.
pred <- model %>%
  predict(final)

# Extract the numeric prediction vector from the tibble returned by `predict()`.
pred <- pred$.pred

# Reshape predictions back into a matrix with the same dimensions
# as the original xx/yy grid. This is required by plotly::add_surface().
pred <- matrix(pred, dim_val[1], dim_val[2])

# Build the interactive 3D visualization:
#  - scatter markers for original data
#  - smooth surface representing the model prediction over the grid
fig <- plot_ly(iris, x = ~Sepal.Width, y = ~Sepal.Length, z = ~Petal.Width) %>%
  add_markers(size = 5) %>%
  add_surface(
    x = xrange,
    y = yrange,
    z = pred,
    alpha = 0.65,
    type = 'mesh3d',
    name = 'pred_surface'
  )

fig

# Export PNG ----------------------------------------------------------------
# (Note: PNG will represent final frame only)
# ggsave(
#   plot = fig,
#   filename = "ggplot-gallery/assets/img/plotly_interactive_scatter.png",
#   width = 7, height = 6, dpi = 150
# )

