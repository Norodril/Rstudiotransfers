df <- mtcars
head(df)

set.seed(123)
df_sample <- df %>%
  sample_n(15, replace = TRUE)
df_sample

#lm(formula, data), where formula describes the model 
#ie. formula - Y ~ X1 + X2
#data = df
model <- lm(mpg ~ hp + wt, data = df_sample)
#summary gives us the coefficients
new_data <- data.frame(
  hp = c(110, 150, 200),
  wt = c(2.5, 3.2, 3.5)
)
summary(model)


predict(model, newdata = new_data) #newdata must be a data frame with the predictor columns defined

#for fitting a logistic regression:
#used when the outcome variable is binary
#example data frame
data_Binary <- data.frame(
  HoursStudied = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  Passed = c(0, 0, 0, 1, 0, 1, 1, 1, 1, 1) #0 = fail, 1 = pass
)

print(data)

model <- glm(Passed ~ HoursStudied, data = data_Binary, family = binomial) #must specify binomial for logistic regression
#Passed is the response variable
#HoursStudied is the precidtor variable
#glm(response ~ predictor1 + predictor2 + ..., data = )
summary(model) #coefficient scale is log-odds (change in logit of Y)

#making predictions
#the model estimates the probability that Passed = 1
#probabilities tell you how likely each student is to pass
data_Binary$pred_prob <- predict(model, type = "response")
print(data_Binary)
#for logistic regression, probabilities are not automatically stored
#you must call predict(model, type = "response") to get them

#converting probabilities to binary predictions
data_Binary$pred_class <- ifelse(data_Binary$pred_prob > 0.5, 1, 0)
print(data_Binary)
#predicting for new data
new_data <- data.frame(HoursStudied = c(3, 5, 7))
new_data$pred_prob <- predict(model, newdata = new_data, type = "response")
new_data$pred_class <- ifelse(new_data$pred_prob > 0.5, 1, 0)
print(new_data)




