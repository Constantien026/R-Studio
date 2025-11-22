#### hist
#Histogram using R base graphics

par(mfrow=c(1,3))
hist(hb, main = "Modern Englishman", xlab = "head breath (mm)")
# Basic histogram with 15 breaks
hist(hb, breaks = 15, main="Histogram, 15 breaks")

# freq=FALSE changes the vertical axis to density,
# so the total area of the bars is now equal to 1
hist(hb, breaks = 8, freq = FALSE, main="Histogram, density")

# Histogram using ggplot
library(ggplot2)

# First put hb vector into a data.frame
hb_df <- data.frame(hb)

p <- ggplot(hb_df, aes(x = hb))

# Always specify a binwidth for the histogram (default is range/30)
# try several binwidths
p <- p + geom_histogram(binwidth = 5)
p <- p + labs(title = "Modern Englishman head breadth")
print(p)
