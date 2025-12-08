library(ggplot2)
library(viridis)
library(ggridges)


df <- data.frame(
  x = rnorm(100),
  y = rnorm(100), 
  #vector of random letters (assignments)
  group = sample(letters[1:3], 100, TRUE)
  )

#color scatterplot according to categorical color value
ggplot(df, aes(x=x, y=y, color = group)) +
  geom_point() +
  scale_color_viridis(discrete = TRUE)

ridgeline <- data.frame(
  value = c(rnorm(100, 5, 1), rnorm(100, 7, 1.22), rnorm(100, 6, 1.5)),
  group = rep(c("A", "B", "C", each = 100))
)

ggplot(ridgeline, aes(x = value, y = group, fill = group)) +
  geom_density_ridges() +
  scale_fill_viridis_d() + 
  labs(title = "Ridgeline Plot of Groups A, B, C", x = "Value", y = "Group") +
  theme_minimal()

#dumbbell 
dumbbell <- data.frame(
  category = c("X", "Y", "Z", "W"),
  start = c(10, 15, 7, 12),
  end = c(20, 18, 12, 15)
)

#Dumbbell plot
ggplot(dumbbell, aes(y = category)) +
  geom_segment(aes(x = start, xend = end, yend = category),
               color = "#a3c4dc") +
  geom_point(aes(x = start), color = "#0e668b") +
  geom_point(aes(x = end), color = "#c64756")
  labs(title = "Dumbbel Plot", x = "Value", y = "Category") +
  theme_minimal()

  #multiple boxplots
  




