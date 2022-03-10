midwest <- as.data.frame(ggplot2::midwest)

head(midwest)
tail(midwest)
View(midwest)
dim(midwest)

install.packages('dplyr')
library(dplyr)

midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)

midwest$전체_인구_대비_이사아_인구_비율 <- midwest$asian / midwest$total

hist(midwest$전체_인구_대비_이사아_인구_비율)

totla_mean <- mean(midwest$전체_인구_대비_이사아_인구_비율)
midwest$grade <- ifelse(midwest$전체_인구_대비_이사아_인구_비율 > totla_mean, 'large', 'small')

table(midwest$grade)
library(ggplot2)
qplot(midwest$grade)
