#simple scatterplot with help color code
library(ggplot2)
library(viridis)
library(RColorBrewer)

df <- data.frame(
  x = rnorm(50),
  y = rnorm(50),
  category = sample(c("Male", "Female"), 50, replace = TRUE)
)

ggplot(df, aes(x = x, y = y, color = category)) +
  geom_point(size = 4) +
  labs(title = "X vs Y Values of Men vs Women", x = "X Value", y = "Y Value") +
  scale_color_manual(values = c("Female" = "#AA00AA", Male = "#00A0AA"))

ggplot(df, aes(x =x, y=y, color = category)) +
  geom_point(size = 4) +
  labs(title = "Men vs Women using RColorBrewer") +
  scale_color_brewer(palette = "Spectral")

data2 <- data.frame(
  x = rep(1:10, times = 10),
  y = rep(1:10, each = 10),
  value = runif(100)
)

ggplot(data2, aes(x = x, y = y, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "pink", high = "purple") +
  labs(title = "Hex Heat Map using Scale_Fill_Gradient")

ggplot(data2, aes(x = x, y = y, fill = value)) +
  geom_tile() +
  scale_fill_viridis(option = "F") +
  labs(title = "Hex Heat Map using Viridis")

df2 <- data.frame(
  x = rnorm(1000),
  y = rnorm(1000)
)

ggplot(df2, aes(x = x, y = y)) +
  geom_hex(bins = 15) + # number of bins
  theme_bw() +
  scale_fill_viridis() +
  labs(title = "Basic Hexbin Plot")

