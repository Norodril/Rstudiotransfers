#Simulating real regression data
x <- rnorm (100)
y <-3 + 2 * x + rnorm(100, sd = 1)

#putting x and y together into a dataframe called data
data <- data.frame(y = y, x = x)

#fitting the original linear regression model
#this is the baseline before bootstrapping
model <- lm(y ~ x, data = data)
summary(model)

#creating empty 100x2 matrix for the intercepts and slopes
#1000 rows for 1000 bootstrap samples
boot_coefs <- matrix(NA, nrow = 1000, ncol = 2)
colnames(boot_coefs) <- c("Intercept", "Slope")

#Bootstrap Loop
for (b in 1:1000){
  #vector of 100 randomly generated values from 1-100
  #this represents a vector of row numbers
  sampled_row <- sample(1:100, 100, replace = TRUE)
  #taking the sampled row and placing it in a new dataset called boot_data
  boot_data <- data[sampled_row, ] #takes the x and y values from data and stores it in boot_data
  boot_model <- lm(y ~ x, data = boot_data)
  boot_coefs[b, ] <- coef(boot_model) #specifies add the data to row b, all columns
}

head(boot_coefs)

#comparing the coefficients of the original and the bootstrap regression
coef(model)
apply(boot_coefs, 2, mean)

#if the original dataset is a good representation of the population
#the mean of all bootstrap slopes ~ = to the original slope
#the mean of all bootstrap intercepts ~ = to the original intercept

#comparing SDs
apply(boot_coefs, 2, sd)
sd(data$x)
sd(data$y)

