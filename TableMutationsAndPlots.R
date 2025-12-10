library(dplyr)
library(ggplot2)
df1 <- data.frame(
  names = c("Ava", "Josh", "Maya", "Alex"),
  english_scores = c(90, 30, 50, 88),
  math_scores = c(80, 68, 60, 75),
  history_scores = c(92, 40, 75, 93),
  grade_lvl = c("Seventh", "Sixth", "Seventh", "Sixth")
)

df_mutated <- df1 %>%
  mutate(
    average_total = (english_scores + math_scores + history_scores)/3
  )
print(df_mutated)
#apply() applies a function across rows or collumns of a matrix or df
df_applied <- data.frame(
  nums = c(1, 12, 14, 16),
  nums2 = c(2, 14, 13, 20)
  )

df_applied %>%
  apply(1, sum)

#lapply applies a function to list or vector
vector_lapply <- c(1, 2, 3, 4, 5)
print(lapply(vector_lapply, function(x) x^2))

#order(df) returns a list of indicies that would sort the data frame
#order(df, na.last = T/F/NA, decreasing = FALSE)

#sort(x, decreasing = T/F, na.last = T/F/NA) returns the sorted vector directly 

#unique(df) returns the distinct elements from the df

#left_join(x, y, by = keyname) keeps all rows from x and matches rows from y and fills rest with na
#right_join(x, y, by = keyname) keeps all rows from y and matches rows from x and fills rest with na
#inner_join(x, y, by = keyname) keeps all rows that only appear in x and y and matches by keyname
#full_join(x, y, by = keyname) keeps all rows from boy x and y and fills rest with nas

#filter
df_filtered <- df_mutated %>%
  filter(average_total > 80)

#select
df_selected <- df1 %>%
  select(names, grade_lvl)
print(df_selected)

#arrange
df_arranged <- df1 %>%
  arrange(names) #alphabetical (least to greatest)
#to sort from greatest to least or descending, you must specify in the column argument using desc(col)


#slice (for rows)
df_sliced <- df1 %>%
  slice(2:3)

#summarise
df_summarized <- df1 %>%
  summarise(mean(english_scores), mean(math_scores), mean(history_scores))
print(df_summarized)

#group_by + summarise
df_grouped_and_summarized <- df1 %>%
  group_by(grade_lvl) %>%
  summarise(mean(english_scores), mean(math_scores), mean(history_scores))
print(df_grouped_and_summarized)

ggplot(df_mutated, aes(x = names, y = average_total, fill = grade_lvl)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "Dark2")

