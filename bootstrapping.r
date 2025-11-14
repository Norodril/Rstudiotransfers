set.seed(1)
x <- c(10, 12, 13, 9, 14, 11)
boot_medians <- replicate(1000, median(sample(x, length(x), replace = TRUE)))
median_hat <- median(x)
SE_median_boot <- sd(boot_medians)

boot_medians
median_hat
SE_median_boot

hist(boot_medians, main = "Bootstrap Medians", xlab = "Medians")
abline(v = median_hat, col="red", lwd=2)

CI_boot <- quantile(boot_medians, c(0.025, 0.975))
CI_boot