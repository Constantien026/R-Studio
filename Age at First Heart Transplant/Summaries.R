#Einstien Stephen Matthew D. Poblete

age <- c(54, 42, 51, 54, 49, 56, 33, 58, 54, 54, 49)


par(mfrow = c(2, 1))
hist(age, freq = FALSE, breaks = 6)
points(density(age), type = "l")  # use "l" (line), not "1"
run(age)

library(vioplot)
vioplot(age, horizontal = TRUE, col = "gray")

stem(age, scale =2)

The decimal point is 1 digit(s) to the right of the |
  
  3 | 3
3 |  
  4 | 2
4 | 99
5 | 14444
5 | 68

qt(1 - 0.05/2, df = length(age) - 1)


?t.test

t.summary <- t.test(age, mu=50)
t.summary

summary(age)

t.dist.pval <- function(t.summary){
  par(mfrow = c(1, 1))
  lim_extreme <- max(4, abs(t.summary$statistic) + 0.5)
  lim_lower <- -lim_extreme
  lim_upper <- lim_extreme
  x.curve <- seq(lim_lower, lim_upper, length = 200)
  y.curve <- dt(x.curve, df = t.summary$parameter)
  
  plot(x.curve, y.curve, type = "l",
       ylab = paste("t-dist( df =", signif(t.summary$parameter, 3), ")"),
       xlab = paste("t-stat =", signif(t.summary$statistic, 5),
                    ", Shaded area is p-value =", signif(t.summary$p.value, 5)))
  
  if ((t.summary$alternative == "less") |
      (t.summary$alternative == "two.sided")) {
    x.pval.l <- seq(lim_lower, -abs(t.summary$statistic), length = 200)
    y.pval.l <- dt(x.pval.l, df = t.summary$parameter)
    polygon(c(lim_lower, x.pval.l, -abs(t.summary$statistic)),
            c(0, y.pval.l, 0), col = "gray")
  }
  
  if ((t.summary$alternative == "greater") |
      (t.summary$alternative == "two.sided")) {
    x.pval.u <- seq(abs(t.summary$statistic), lim_upper, length = 200)
    y.pval.u <- dt(x.pval.u, df = t.summary$parameter)
    polygon(c(abs(t.summary$statistic), x.pval.u, lim_upper),
            c(0, y.pval.u, 0), col = "gray")
  }
  
  points(x.curve, y.curve, type = "l", lwd = 2, col = "blue")
}

t.dist.pval(t.summary)

names(t.summary)

t.summary$statistic
t.summary$parameter
t.summary$p.value
t.summary$conf.int
t.summary$estimate
t.summary$null.value
t.summary$stderr
t.summary$alternative
t.summary$method
t.summary$data.name
