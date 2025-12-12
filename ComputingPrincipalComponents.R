Y <- matrix(c(2, 5, 3, 6, 7,
              4, 3, 6, 2, 4,
              3, 8, 19, 2, 1,
              3, 6, 17, 3, 4,
              1, 3, 7, 4, 15,
              3, 15, 2, 3, 1), ncol = 5, byrow = TRUE)

colnames(Y) <- c("Predictor1", "Predictor2", "Predictor3", "Predictor4", "Predictor5")
rownames(Y) <- paste0("Obs", 1:6)
print(Y)

pca <- prcomp(Y, center = TRUE, scale. = TRUE)
print(pca)
print(pca$x) #all scores (predictor x weight)
print(pca$rotation[1, ]) #first row all PC weights/loadings
print(pca$rotation[, 1]) #first column all predictors
print(pca$sdev[1]) #sd PC1
print(pca$scale[1]) 

