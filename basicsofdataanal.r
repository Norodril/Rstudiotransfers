library(tidyverse)

students1 <- tibble(
  Math = c("90", "30", "20", "88"),
  English = c("80", "20", "40", "15"),
  Student = c("Andrew", "Maria", "Jake", "Emily")
)

students2 <- tibble(
  Student = c("Andrew", "Maria", "Jake", "Emily"),
  Grade = c(4, 5, 3, 4)
)

print(students2)

finalStudents <- full_join(students1, students2, by = "Student")

print(finalStudents)

SubjectsCondensed <- pivot_longer(
  finalStudents,
  cols = c("Math", "English"),
  names_to = "Subject",
  values_to = "Grade Earned"
)

print(SubjectsCondensed)

SubjectsReversed <- pivot_wider(
  SubjectsCondensed,
  names_from = "Subject",
  values_from = "Grade Earned"
)

print(SubjectsReversed)