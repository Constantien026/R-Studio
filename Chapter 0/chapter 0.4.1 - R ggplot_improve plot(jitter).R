####Installation
install.package("ggplot2")
####Library
library(ggplot2)

####dataset
?mpg
#### mmgp dataset
head(mpg)
str(mpg)
summary(mpg)

####ggplot_mpg_displ_hwy
p <- ggplot(mpg, aes(x = cty, y = hwy))
#normal
p <- p + geom_point(position = "jitter", alpha = .5)
print(p)
