library(ggplot2)
library(ggridges)


#creates a data frame with 300 randomly geerated numbers from different normal distributions
#Creates an additional column called groups that have random age groups in them 
set.seed(123)
df_ridge <- data.frame(
  values_for_density = c(rnorm(100, mean = 0),
                         rnorm(100, mean = 4),
                         rnorm(100, mean = 16, sd = 3)),
  #vector to randomly designate age categories to the numbers generated above
  groups = factor(rep(c("0-20", "21-50", "50+"), times = 2, each = 50))
  )

#plotting this data in a ridgeline density plot
ggplot(df_ridge, aes (x = values_for_density, y = groups, fill = groups)) +
  geom_density_ridges() +
  theme_minimal() +
  labs(title = "Ridgeline Plot Example", x = "Value", y = "Age Ranges") +
  scale_fill_brewer()

#Generates xy pairs from 2 different normally distributed samples of 300 with different means
#randomly groups each xy pair with a group alternating between groups 1 2 and 3
df_scatter<- data.frame(
  x = rnorm(300, mean = 2),
  y = rnorm(300, mean = 10),
  group = factor(rep(c("Group 1", "Group 2", "Group 3"), each = 1, times = 100))
)

#creating a side by side scatterplot using facet_wrap(~categorical)
#facet_wrap(rows ~ cols)
ggplot(df_scatter, aes(x = x, y = y, color = group)) +
  geom_point() +
  facet_wrap(~group, ncol = 1) + 
  theme_minimal() +
  labs(title = "Side-by-side Scatterplots for all 3 groups (X vs Y)") +
  scale_color_viridis(discrete = TRUE, option = "plasma")


#data frame with 3 start and end points for the data, to be classified by cat category
df_dumbbell <- data.frame(
  category = c("Cat1", "Cat2", "Cat3"),
  start = c(5, 10, 15),
  end = c(8, 12, 18)
)

#dumbbell plot
#y = category tells ggplot the dumbbells will be stacked vertically along categories
# x start and xend end tell ggplot what will determine the length of the line along the horizontal axis
ggplot(df_dumbbell, aes(y = category, x = start, xend = end, color = "#AA00AA")) +
  geom_segment() +
  geom_point(aes(x = start), color = "#00A0AA") +
  geom_point(aes(x = end), color = "#088748") +
  theme_minimal() +
  labs(title = "Dumbbell Plot for Cat Groups", x = "Value", y = "Category")


#Multiple BoxPlots
#creates dataframe with randomly generated values from 3 normal distributions and assigns them to a random group
df_boxplot <- data.frame(
  value = c(rnorm(51, 5),
            rnorm(51, 7),
            rnorm(51, 6)),
  group = factor(rep(c("Group 1", "Group 2", "Group 3"), times = 17, each = 1))
)
  
ggplot(df_boxplot, aes(y = group, x = value, fill = group)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Multiple Boxplots Example") +
  scale_fill_viridis_d(option = "inferno") 
  
  
  
  
