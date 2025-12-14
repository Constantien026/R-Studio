#Einstien Stephen Matthew D. Poblete

age <- c(54, 42, 51, 54, 49, 56, 33, 58, 54, 54, 49)


par(mfrow = c(2, 1))
hist(age, freq = FALSE, breaks = 6)
points(density(age), type = "l")  # use "l" (line), not "1"
run(age)

install.packages("vioplot")
library(vioplot)
vioplot(age, horizontal = TRUE, col = "gray")


