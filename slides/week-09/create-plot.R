set.seed(75)
n <- 16
x1 <- runif(n)
x2 <- runif(n)
group <- as.factor(sample(1:3, n, replace = TRUE))
df <- data.frame(x1, x2, group)
df[1, 2] <- .765
df[9, 1] <- .741
df <- df[-7, ]

library(ggplot2)
pdf("3-class-plot.pdf", height = 4, width = 5)
ggplot(df, aes(x = x1, y = x2, col = group, shape = group)) +
  geom_point(size = 4) +
  scale_x_continuous(expand = c(0, 0) , limits = c(0, 1)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1)) +
  theme_bw()
dev.off()

#


