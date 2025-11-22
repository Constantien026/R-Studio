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
p <- p + geom_point()

##two methods
p1 <- p + facet_grid(. ~ cyl)
p2 <- p + facet_grid(drv ~ .)
p3 <- p + facet_grid(drv ~ cyl)
p4 <- p + facet_grid(~ class)


library(gridExtra)
grid.arrange(p1, p2, p3, p4, ncol = 2)
print(p)
