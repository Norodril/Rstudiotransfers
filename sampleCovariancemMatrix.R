X <- matrix(c(1, 2, 3,
              2, 3, 4,
              3, 5, 5, 
              5, 6, 7), ncol = 3, byrow = TRUE)
colnames(X) <- c("Var1", "Var2", "Var3")
print(X)


#covariance matrix = square matrix that shows how all pairs of variables (columns) vary together
#values outputted are the covariance values of 
cov_matrix <- cov(X)
print(cov_matrix)

#different matrix
Y <- matrix(c(2, 5, 3, 6, 7,
              4, 3, 6, 2, 4,
              3, 8, 19, 2, 1,
              3, 6, 17, 3, 4,
              1, 3, 7, 4, 15,
              3, 15, 2, 3, 1
              ), ncol = 5, byrow = TRUE)

colnames(Y) <- c("Predictor1", "Predictor2", "Predictor3", "Predictor4", "Predictor5")
print(Y)

print(cov(Y))
