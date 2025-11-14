library(tidyverse)

students1 <- tibble(
  names = c("Emily", "Jack", "Ana", "Bob", "Max"),
  Math = c(90, 88, 47, NA, 30),
  Science = c(44, NA, 28, 80, 20)
)

#pivot_long
longTable <- pivot_longer(
  students1,
  cols = c(Math, Science),
  names_to = "Subject",
  values_to = "Score"
)
print(longTable)

#pivot_wide
print(pivot_wider(
  longTable,
  names_from = "Subject",
  values_from = "Score"
))

students2 <- tibble(
  names = c("Emily", "Jack", "Ana", "Bob", "Max"),
  score3 = c(80, 10, 40, NA, 20)
)

#inner_join, left_join, right_join, full_join
BothStudents <- full_join(students1, students2, by = "names")
print(BothStudents)

#mutate
print(students1 %>%
        mutate(
          total = Math + Science
        ))

#group_by, summarise
print(longTable %>%
        group_by(Subject)%>%
        summarise(mean(Score, na.rm = TRUE)))

#select
print(BothStudents %>%
        select(names, Math, score3))

#across data with ~ .x
print(BothStudents %>%
  summarise(across(c(Math:score3), ~mean(.x, na.rm = TRUE)))
  )

#slice rows by number
print(students1 %>%
        slice(1:2))

#slice specific rows
print(students1 %>%
        slice(c(1, 2, 3)))

#slice selecting the last row
#this is because n() counts how many rows are in the dataset
print(students1 %>%
        slice(n()))

#distinct removing duplicate rows or combinations of selected rows
#removing all duplicates
print(students1 %>%
         distinct())

#removing duplicates unique to a column
#will only print the row it was provided (removing duplicates)
print(students1 %>%
        distinct(names))

#if you want all other columns to show
print(students1 %>%
        distinct(names, .keep_all = TRUE))

#Keeping distinct multiple columns
print(students1 %>%
        distinct(names, Science))

print(students1 %>%
        distinct(names, Science, .keep_all = TRUE))

#renaming columns, keeping all data just changing column names
print(students1 %>%
        rename(
          FirstNames = names,
          mathScore = Math,
          scienceScore = Science))

print(is.na(BothStudents))

filter(longTable, Subject == "Math", Score > 60)

