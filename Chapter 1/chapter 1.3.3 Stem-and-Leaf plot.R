hb <- c(141, 148, 132, 138, 154, 142, 150, 146, 155
        , 158, 150, 140, 147, 148, 144, 150, 149, 145)

### stem-and-leaf
#### basic stem-leaf plot
stem(hb)
##
## The decimal point is 1 digit(s) to the right of the |
##


# scale=2 makes plot roughly twice as wide
stem(hb, scale=2)
##
## The decimal point is 1 digit(s) to the right of the |


# scale=0 makes plot roughly five times as wide
stem(hb, scale=5)
##
## The decimal point is at the |
