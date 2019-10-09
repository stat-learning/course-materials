## ----echo = FALSE--------------------------------------------------------
library(knitr)
opts_chunk$set(warning = FALSE, message = FALSE)


## ------------------------------------------------------------------------
library(ISLR)
data(Default)
head(Default)


## ------------------------------------------------------------------------
library(dplyr)
est <- Default %>%
  group_by(default) %>%
  summarize(n = n(),
            prop = n/nrow(Default),
            mu = mean(balance),
            ssx = var(balance) * (n - 1))
est


## ------------------------------------------------------------------------
pi_n <- as.numeric(est[1, 3])
pi_y <- as.numeric(est[2, 3])
mu_n <- as.numeric(est[1, 4])
mu_y <- as.numeric(est[2, 4])
sig_sq <- (1/(nrow(Default) - 2)) * sum(est$ssx)


## ------------------------------------------------------------------------
my_lda <- function(x, pi, mu, sig_sq) {
  x * (mu/sig_sq) - (mu^2)/(2 * sig_sq) + log(pi)
}


## ------------------------------------------------------------------------
d_n <- my_lda(Default$balance, pi_n, mu_n, sig_sq)
d_y <- my_lda(Default$balance, pi_y, mu_y, sig_sq)


## ---- echo = FALSE, fig.width=8, fig.height = 5.5, fig.align = "center"----
library(ggplot2)
balance <- seq(0, max(Default$balance), length.out = 50)
dx <- c(my_lda(balance, pi_n, mu_n, sig_sq), my_lda(balance, pi_y, mu_y, sig_sq))
default <- as.factor(rep(c("No", "Yes"), each = 50))
df <- data.frame(balance = rep(balance, 2), dx, default)

p1 <- ggplot(df, aes(x = balance, y = dx, color = default)) +
  geom_line(lwd = 1.3) + 
  theme_bw()
p1 +
  theme(axis.title.x = element_text(size = rel(1.5)),
        axis.title.y = element_text(size = rel(1.5)),
        legend.text  = element_text(size = rel(1.5)),
        legend.title = element_text(size = rel(1.5)))


## ----echo = FALSE, fig.align="center", fig.height = 2.5------------------
Default %>%
  ggplot(aes(x = balance, fill = default)) +
  geom_density(alpha = .5) +
  theme_bw()


## ----echo = FALSE, fig.align="center", fig.height = 2.5------------------
p1


## ----echo = FALSE, fig.align="center", fig.height = 2.5------------------
Default %>%
  ggplot(aes(x = balance, fill = default)) +
  geom_histogram(col = "black") +
  theme_bw()


## ---- echo = FALSE, fig.align="center", fig.heigh = 8--------------------
Default <- mutate(Default, defaultYes = ifelse(default == "Yes", 1, 0))
  
p3 <- ggplot(Default, aes(x = balance, y = defaultYes)) +
  geom_point(pch = 1, alpha = .3, color = "steelblue", size = 3) + 
  ylab("probability of default") + 
  theme_bw()

m1 <- glm(default ~ balance, data = Default, family = binomial)
thresh <- (log(.5/.5) - m1$coef[1])/m1$coef[2]

p3 + geom_vline(xintercept = 2000, col = 2) +
  geom_vline(xintercept = thresh) +
  annotate(geom = "text", x = 1600, y = .6, 
           label = "Logistic", size = 6) +
  annotate(geom = "text", x = 2250, y = .6, 
           label = "LDA", size = 6) +
  theme(axis.title.x = element_text(size = rel(1.5)),
        axis.title.y = element_text(size = rel(1.5)))


## ------------------------------------------------------------------------
m1 <- glm(default ~ balance, data = Default,
          family = binomial)
my_log_pred <- ifelse(m1$fit < 0.5, "No", "Yes")
my_lda_pred <- ifelse(d_n > d_y, "No", "Yes")


## ----df, eval = FALSE----------------------------------------------------
## data.frame(log_pred = my_log_pred[8459:8464],
##            lda_pred = my_lda_pred[8459:8464],
##            true = Default$default[8459:8464])


## ----ref.label = "df", echo = FALSE--------------------------------------
data.frame(log_pred = my_log_pred[8459:8464],
           lda_pred = my_lda_pred[8459:8464],
           true = Default$default[8459:8464])


## ----cm1, eval = FALSE---------------------------------------------------
## conf_lda <- table(my_lda_pred, Default$default)
## conf_lda


## ----ref.label = "cm1", echo = FALSE-------------------------------------
conf_lda <- table(my_lda_pred, Default$default)
conf_lda


## ----cm2, eval = FALSE---------------------------------------------------
## conf_log <- table(my_log_pred, Default$default)
## conf_log


## ----ref.label = "cm2", echo = FALSE-------------------------------------
conf_log <- table(my_log_pred, Default$default)
conf_log


## ------------------------------------------------------------------------
(1/nrow(Default)) * (conf_lda[2, 1] + conf_lda[1, 2])


## ------------------------------------------------------------------------
(1/nrow(Default)) * (conf_log[2, 1] + conf_log[1, 2])


## ------------------------------------------------------------------------
set.seed(39)
test_ind <- sample(1:10000, size = 5000)
Default_test <- Default[test_ind, ]
Default_train <- Default[-test_ind, ]