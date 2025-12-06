#Multivariate Regression models the relationship between one response variable
#and multiple predictor variables (X1, X2, X3, X4...)
#fitting a multivariate regression on random data

#1. Generate random data

library(scatterplot3d)
library(ggplot2)
n <- 500
X1 <- rnorm(n, mean = 20, sd = 2)
X2 <- rnorm(n, mean = 30, sd = 3)

Y <- rnorm(n, mean = 50, sd = 10)

df <- data.frame(Y, X1, X2)

model <- lm(Y ~ X1 + X2, data = df)
summary(model)

s3d <- scatterplot3d(df$X1, df$X2, df$Y,
        pch = 19,
        color = "#00A0AA",
        cex.symbols = 0.5,
        xlab = "X1", ylab = "X2", zlab = "Y",
        main = "3D Regression Plane")
s3d$plane3d(model, col = "#AA00AA", lwd = 2)

#2d linear regression

X12 <- rnorm(100, mean = 20, sd = 2)
X22 <- rnorm(100, mean = 30, sd = 3)

Y2 <- 5 + 1.5*X12 - 0.8*X22 + rnorm(100, 0, 5)

df2 <- data.frame(Y2, X12, X22)

model2 <- lm(Y2 ~ X12 + X22, data = df2)
print(summary(model2))

#predicting for new values
newdata <- data.frame(X12 = c(20, 25),
                      X22 = c(30, 28))

predict(model2, newdata)

#when you run lm(), y values (Response variables) in fitted.values
plot(model2$fitted.values, df2$Y2,
     pch = 19, col = "black",
     xlab = "Fitted Values",
     ylab = "Actual Y",
     main = "Actual vs Fitted Y Values")
abline(0, 1, col = "red", lwd = 2)

#ggplot version
ggplot(df2, aes(x = model2$fitted.values, y = Y2)) +
  geom_point(color = "#A00AAA") +
  geom_abline(intercept = 0, slope = 1, color = "black") +
  labs(x = "Fitted Values", y = "Actual Y",
       title = "Actual vs Fitted for Regression Analysis")

#paired bootstrapping
#generating the original dataset
n <- 100
X <- rnorm(n, 20, 2) #predictor var
Y <- 5 + 1.5*X + rnorm(n, 0, 5) #response var w B0 B1 and error
df <- data.frame(X, Y) #add to a data frame

model <- lm(Y ~ X, data = df) #create original regression model
#creating storage for bootstrap estimates
boot_b0 <- numeric(1000) #numeric() creates an empty numeric vector
boot_b1 <- numeric(1000) #these vectors will be filled with the intercepts (B0)
#and sloped (B1) of the bootstrap estimates
for (b in 1:1000){
  #resample rows (paired)
  #randomly picks 100 row number from original data set allowing repeats
  boot_idx <- sample(1:n, n, replace = TRUE)
  #stores it in df_boot data fram
  df_boot <- df[boot_idx, ]
  
  #fit model on bootstrap sample
  boot_fit <- lm(Y ~ X, data = df_boot)
  
  #store coefficients from the linear regression model
  boot_b0[b] <- coef(boot_fit)[1]
  boot_b1[b] <- coef(boot_fit)[2]
}
#creates a histograp using the slope estimates
hist(boot_b1, main = "Bootstrap Slope Estimates")
#line for the original slope for the original model
abline(v = coef(model)[2], col = "#A000AA", lwd = 2)


