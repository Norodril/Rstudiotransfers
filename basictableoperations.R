library(dplyr)
#example dataframe
df <- data.frame(
  names = c("Abby", "Alex", "Thomas", "Emily"),
  math_score = c(88, 92, 76, 85),
  english_score = c(50, 84, 64, 99),
  grade = c("Fourth", "Fourth", "Fifth", "Fifth")
)

#add or motify rows with mutate
df = df %>%
  mutate(total_average = (math_score + english_score) / 2)

#filter rows that only meet a certain condition
df_filtered = df %>%
  filter(total_average > 85)

#selecting certain columns (select can also be used to remove columns)
df_selected = df %>%
  select(names, english_score)

#selecting certain rows by position
df_sliced = df %>%
  slice(1:2)

#collapsing data into one row
#takes mean of all math and english scores for every row
#number of columns is the number of summary variables you ask it to compute
df_summarized = df %>%
  summarise(
    avg1 = mean(math_score),
    avg2 = mean(english_score)
  )

#grouped summary
#number of columns = number of groups
#number of rows in a grouped summary is the number of groups it is summarizing over
df_grouped_and_summarized = df %>%
  group_by(grade) %>%
  summarize(
    avg1 = mean(math_score),
    avg2 = mean(english_score)
  )

#sorting rows by the value of one variable (column)
#default is smallest to largest or a to b, but you can specify desc() to make it largest to smallest
df_arranged <- df %>%
  arrange(names)

print(df)
print(df_grouped_and_summarized)
print(df_arranged)



