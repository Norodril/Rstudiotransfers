library(ggplot2)

#scatterplot with random sampling
#generates 50 random normally distributed points for both x and y
random_data <- data.frame(
  Test_Score = rnorm(50, mean = 80, sd = 10),
  IQ = rnorm(50, mean = 100, sd = 20),
  Continent = sample(c("America", "Asia"), 50, replace = TRUE) #randomly assigns values to different continents
) 

#creating scatterplot based on the data
ggplot(random_data, aes(x = Test_Score, y = IQ, color = Continent))+
  geom_point(size = 3) +
  labs(
    title = "Difference in Test Score and IQ Across Continents",
    x = "Test Score",
    y = "IQ"
  ) +
  scale_color_manual(values = c("America" = "#0045BA", "Asia" = "#00AB23")) +
  theme_minimal()

#creating dataframe to plot
data <- data.frame(
  height = c(50, 74, 78, 57, 63, 80),
  weight = c(110, 170, 180, 130, 145, 200),
  category = c("F", "M", "M", "F", "F", "M")
)

data$category <- factor(data$category, levels = c("M", "F"))

#using boxplot to show the weight distribution by category
ggplot(data, aes(x = category, y = weight, fill = category)) +
  geom_boxplot() +
  labs(
    title = "Weight Distribution by Category",
    x = "Category",
    y = "Weight"
  ) +
  scale_fill_manual( values = c("M" = "#00BFC4", "F" = "#F8766D")) +
  theme_minimal()

#scatterplot
ggplot(data, aes(x = height, y = weight)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Height vs Weight",
    x = "Height",
    y = "Weight",
  ) +
  theme_minimal()

data2 <- data.frame(
  MenandWomen = c("M", "F", "F", "M", "M", "F", "M")
)

ggplot(data2, aes(x = MenandWomen)) +
  geom_bar(fill = "#A0A") +
  labs(
    title = "Number of Men and Women",
    x = "Man (M) or Woman(W)",
    y = "count"
  )

data3 <- data.frame(
  Colors = c("Red", "Blue", "Pink", "Purple", "Green", "White", "Silver"),
  Counts = c(4, 14, 1, 17, 20, 10, 13)
)

ggplot(data3, aes(x = Colors, y = Counts)) +
  geom_line() +
  geom_point(size = 3)

ggplot(data3, aes(x = Colors, y = Counts)) +
  geom_bar(fill = "#0000FF", stat = "identity") +
  labs(
    title = "Number of Colors Chosen",
    x = "Color",
    y = "Count"
  )