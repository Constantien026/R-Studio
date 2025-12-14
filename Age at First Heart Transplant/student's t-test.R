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
