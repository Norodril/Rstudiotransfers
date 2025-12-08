library(ggplot2)
set.seed(123)

#creating data frame
df <- data.frame(
  var1 = rnorm(50, 5, 2),
  var2 = rnorm(50, 10, 3),
  var3 = rnorm(50, 15, 4),
  var4 = rnorm(50, 20, 5),
  var5 = rnorm(50, 25, 6)
)

print(df)

#prcomp does PCA; scale = TRUE standardizes the variables
pca_results <- prcomp(df, scale. = TRUE)
#loadings are the weights of each individual variable
#scores are the coordinates of each variable on the PC plane
summary(pca_result)
#scores = x, loadings = rotation
#scores/new coordinates of Pc1 and Pc2
pc_scores <- data.frame(pca_results$x[, 1:2]) #all rows and select the first 2 columns

#plot of pc1 vs pc2
ggplot(pc_scores, aes(x = PC1, y = PC2)) + #automatically names the columns PC1 and PC2
  geom_point(color = "blue") +
  labs(title = "PCA: PC1 vs PC2", x = "PC1", y = "PC2") +
  theme_minimal()

#bootstrapping PCA
#creating empty vectors
pc1_boot <- numeric(1000)
pc2_boot <- numeric(1000)


for(i in 1:1000) {
  df_boot <- df[sample(1:nrow(df), replace = TRUE), ]
  pca_boot <- prcomp(df_boot, scale. = TRUE)
 
#uses the PC1 and PC2 scores for the first observation
  pc1_boot[i] <- pca_boot$x[1, 1]
  pc2_boot[i] <- pca_boot$x[1, 2]
}

hist(pc1_boot, main = "Bootstrap distribution of PC1", xlab = "PC1")
hist(pc2_boot, main = "Bootstrap distribution of PC2", xlab = "PC2")




