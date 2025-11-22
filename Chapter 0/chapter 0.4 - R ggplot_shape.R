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
p <- ggplot(mpg, aes(x = displ, y = hwy))
#shape
p <- p + geom_point(aes(colour = class, size = cyl, shape = drv))
print(p)
