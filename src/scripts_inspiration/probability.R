##############################
##   Binomial distribution  ##
##############################
library(tidyverse)
# install.packages("flextable")
library(flextable)

theme_colors <- data.frame(light_blue = "#619CFF", light_orange = "#ffc461")
theme_colors

theme_set(theme_light())

# Flipping a coin

# rbinom(n, size, prob)
#   n    = number of observations (coins)
#   size = number of trials - flips (zero or more)
#   prob = probability of success on each trial
rbinom(n = 1, size = 1, prob = .5)
# [1] 1

# Flipping multiple coins
rbinom(n = 1, size = 10, prob = .5)

# Multiple flips
rbinom(n = 10, size = 1, prob = .5)
# [1] 1 0 0 0 0 0 0 0 0 1

# Flip one coin 10,000 times
coin_flips_single <- data.frame(flips_1 = rbinom(n = 100000, size = 1, prob = .5)) %>%
    as_tibble() %>%
    rowid_to_column("id")

# Flip 10, 100 and 1000 coins 10,000 times
coin_flips_multiple <- data.frame(
    flips_10 = rbinom(n = 100000, size = 10, prob = .5),
    flips_100 = rbinom(n = 100000, size = 100, prob = .5),
    flips_1000 = rbinom(n = 100000, size = 1000, prob = .5)
) %>%
    as_tibble() %>% rowid_to_column("id") %>%
    gather(n, heads, -id)

# Compute probabilities
coin_flips_multiple_prob <- coin_flips_multiple %>%
    group_by(n, heads) %>%
    summarize(freq = n(), prob = freq / 100000)

# Histogram
ggplot(coin_flips_multiple, aes(x = heads)) +
    geom_histogram(fill = "steelblue") +
    facet_wrap(~n, scales = "free")

# Densities
ggplot(coin_flips_multiple, aes(x = heads)) +
    geom_density(fill = "steelblue", alpha = 0.5, adjust = 10) +
    facet_wrap(~n, scales = "free_x")

coin_flips <- coin_flips_multiple %>% spread(n, heads)

coin_flips_results <- data.frame(
    table(coin_flips$flips_10),
    prop.table(table(coin_flips$flips_10)) %>% round(3),
    cumulative = cumsum(prop.table(table(coin_flips$flips_10))) %>% round(3)
) %>% select(-Var1.1)
names(coin_flips_results) <- c("result", "n", "prop", "cumulative")
coin_flips_results <- coin_flips_results %>% as.matrix() %>% t() %>% as.data.frame()
coin_flips_results <- rownames_to_column(coin_flips_results, "heads")
flextable::flextable(coin_flips_results[-1,])

flips <- rbinom(n = 100000, size = 10, prob = .5)

sd(flips)
# [1] 1.578884
mean(flips)
# [1] 4.99454
mean(flips == 5) + mean(flips < 5) + mean(flips > 5)


flips <- rbinom(n = 100000, size = 10, prob = .5)
# Plot for prop table of coin flips
flips %>%
    table() %>% as_tibble() %>%
    ggplot(aes(x = factor(., levels = 0:10), y = n / 100000, fill = .)) +
        geom_col() +
        theme(legend.position = "none", text = element_text(size = 20)) +
        xlab("N of heads out of 10 coin flips") +
        ylab("Result probability")

# Plot with highlighted part where there are exactly 5 heads
flips %>%
    table() %>% as_tibble() %>%
    ggplot(aes(x = factor(., levels = 0:10), y = n / 100000, fill = !(. == 5))) +
        geom_col() +
        theme(legend.position = "none", text = element_text(size = 20)) +
        xlab("N of heads out of 10 coin flips") +
        ylab("Result probability")

mean(flips == 5)


# Plot with highlighted part where there are exactly 5 heads
flips %>%
    table() %>% as_tibble() %>%
    ggplot(aes(x = factor(., levels = 0:10), y = n / 100000, fill = !(factor(., levels = 0:10) %in% 0:2))) +
        geom_col() +
        theme(legend.position = "none", text = element_text(size = 20)) +
        xlab("N of heads out of 10 coin flips") +
        ylab("Result probability")

mean(flips < 3)
sum(flips < 3)

###########################################

# Calculating exact ("real") probability
# dbinom(x, size, prob, log = FALSE)
dbinom(x = 5, size = 10, prob = .5) # 5 from 10 coins
# [1] 0.2460938
dbinom(x = 6, size = 10, prob = .5) # 6 from 10 coins
# [1] 0.2050781
dbinom(x = 10, size = 10, prob = .5) # 10 from 10 coins
# [1] 0.0009765625

###########################################

# Calculating probability density
pbinom(q = 4, size = 10, prob = .5) # 4 or less heads from 10 coins
# [1] 0.3769531

# The same as
flips <- rbinom(n = 100000, size = 10, prob = .5)
mean(flips <= 4)
# [1] 0.37326

mean(rbinom(n = 100000, size = 10, prob = .5))
sd(rbinom(n = 100000, size = 10, prob = .5))

# Compute mean
size <- 100 # Number of coins to flip
prob <- 0.5 # Probability
data.frame(
    var = round(size * prob * (1 - prob), 3),
    sd = round(sqrt(size * prob * (1 - prob)), 3),
    mean = size * prob
)


# Compute probability of getting 56 heads out of 100 using binomial formula
P_56_heads <- dbinom(x = 56, size = 100, prob = 0.5)
P_56_heads

# To calculate the two-tailed probability P(X ≥ 56) + P(X ≤ 44) for flipping 100 coins
n <- 100
p <- 0.5

# Calculate P(X >= 56) and P(X <= 44)
P_ge_56 <- sum(dbinom(x = 56:100, size = 100, prob = 0.5))
P_le_44 <- sum(dbinom(x = 0:44, size = 100, prob = 0.5))

# Calculate two-tailed probability
two_tailed_prob <- P_ge_56 + P_le_44
two_tailed_prob



