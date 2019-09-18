## ----setup, include=FALSE------------------------------------------------
library(knitr)
options(digits=3)
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)

## ----getdata, echo = FALSE, message=FALSE--------------------------------
library(DAAG)
data(allbacks)
books <- allbacks

## ----plotallbacks--------------------------------------------------------
ggplot(books, aes(x = volume, y = weight)) + geom_point()

## ----fitm1, echo = FALSE-------------------------------------------------
m1 <- lm(weight ~ volume, data = books)

## ----plotallbackswline---------------------------------------------------
ggplot(books, aes(x = volume, y = weight)) + 
  geom_point() +
  geom_abline(intercept = m1$coef[1], slope = m1$coef[2], col = "orchid")

## ------------------------------------------------------------------------
m1 <- lm(weight ~ volume, data = books)
summary(m1)

## ----eval = FALSE--------------------------------------------------------
## lm(Y ~ X1 + X2 + ... + Xp, data = mydata)

## ----plotcolors----------------------------------------------------------
ggplot(books, aes(x = volume, y = weight, color = cover)) +
  geom_point()

## ------------------------------------------------------------------------
m2 <- lm(weight ~ volume + cover, data = books)
summary(m2)

## ----echo = FALSE--------------------------------------------------------
ggplot(books, aes(x = volume, y = weight, color = cover)) +
  geom_point() +
  geom_abline(intercept = m2$coef[1], slope = m2$coef[2], col = 2) +
  geom_abline(intercept = m2$coef[1] + m2$coef[3], slope = m2$coef[2], col = 4)

## ----eval = FALSE--------------------------------------------------------
## LA <- read.csv("http://andrewpbray.github.io/data/LA.csv")

## ------------------------------------------------------------------------
LA <- read.csv("http://andrewpbray.github.io/data/LA.csv")
LA <- mutate(LA, logprice = log(price), logsqft = log(sqft))
m1 <- lm(logprice ~ logsqft + bed + city, data = LA)
summary(m1)

## ----eval = FALSE, echo = FALSE------------------------------------------
## library(rgl)
## colvec <- rep("steelblue", dim(LA)[1])
## colvec[LA$city == "Long Beach"] <- "orange"
## colvec[LA$city == "Santa Monica"] <- "red"
## colvec[LA$city == "Westwood"] <- "green"
## plot3d(x = LA$logsqft, y = LA$bed, z = LA$logprice, col = colvec,
##        xlab = "Logsqft", ylab = "# Beds", zlab = "Price")
## coefs <- m1$coef
## planes3d(coefs["logsqft"], coefs["bed"], -1, coefs["(Intercept)"],
##          alpha = 0.4, col = "steelblue")
## planes3d(coefs["logsqft"], coefs["bed"], -1,
##          coefs["(Intercept)"] + coefs["cityLong Beach"],
##          alpha = 0.4, col = "orange")
## planes3d(coefs["logsqft"], coefs["bed"], -1,
##          coefs["(Intercept)"] + coefs["citySanta Monica"],
##          alpha = 0.4, col = "red")
## planes3d(coefs["logsqft"], coefs["bed"], -1,
##          coefs["(Intercept)"] + coefs["cityWestwood"],
##          alpha = 0.4, col = "green")

## ------------------------------------------------------------------------
m2 <- lm(logprice ~ logsqft + bed + city + logsqft:city, data = LA)

## ------------------------------------------------------------------------
summary(m2)

## ----eval = FALSE, echo = FALSE------------------------------------------
## colvec <- rep("steelblue", dim(LA)[1])
## colvec[LA$city == "Long Beach"] <- "orange"
## colvec[LA$city == "Santa Monica"] <- "red"
## colvec[LA$city == "Westwood"] <- "green"
## plot3d(x = LA$logsqft, y = LA$bed, z = LA$logprice, col = colvec,
##        xlab = "Logsqft", ylab = "# Beds", zlab = "Price")
## coefs <- m2$coef
## planes3d(coefs["logsqft"], coefs["bed"], -1, coefs["(Intercept)"],
##          alpha = 0.4, col = "steelblue")
## planes3d(coefs["logsqft"] + coefs["logsqft:cityLong Beach"], coefs["bed"], -1,
##          coefs["(Intercept)"] + coefs["cityLong Beach"],
##          alpha = 0.4, col = "orange")
## planes3d(coefs["logsqft"] + coefs["logsqft:citySanta Monica"], coefs["bed"], -1,
##          coefs["(Intercept)"] + coefs["citySanta Monica"],
##          alpha = 0.4, col = "red")
## planes3d(coefs["logsqft"] + coefs["logsqft:cityWestwood"], coefs["bed"], -1,
##          coefs["(Intercept)"] + coefs["cityWestwood"],
##          alpha = 0.4, col = "green")

## ------------------------------------------------------------------------
m3 <- lm(logprice ~ logsqft + bed + logsqft:bed, data = LA)

## ------------------------------------------------------------------------
summary(m3)

## ----echo = FALSE, eval = FALSE------------------------------------------
## my_surface <- function(f, n=10, ...) {
##   ranges <- rgl:::.getRanges()
##   x <- seq(ranges$xlim[1], ranges$xlim[2], length=n)
##   y <- seq(ranges$ylim[1], ranges$ylim[2], length=n)
##   z <- outer(x,y,f)
##   surface3d(x, y, z, ...)
## }
## coefs <- coef(m3)
## f <- function(x1, x2){
##   coefs["(Intercept)"] + coefs["logsqft"] * x1 + coefs["bed"] * x2 + coefs["logsqft:bed"] * x1 * x2
## }
## 
## x1 <- LA$logsqft
## x2 <- LA$bed
## plot3d(x = x1, y = x2, z = LA$logprice, col = "red", alpha = .5,
##        xlab = "Logsqft", ylab = "# Beds", zlab = "Price", site = 5)
## my_surface(f, alpha=.2 )

