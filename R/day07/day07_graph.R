# 그래프

getwd()
setwd('C:/Souuces/StudyR/day07')

mpg <- as.data.frame(ggplot2::mpg)
economics <- as.data.frame(ggplot2::economics)
exam <- read.csv('C:/Souuces/StudyR/Data/csv_exam.csv')

library(ggplot2)
install.packages('dplyr')
library(dplyr)

## 선 그래프
head(economics)
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

## 상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
class_mpg <- mpg %>% filter(class == 'compact' | class == 'subcompact' | class == 'suv')
ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()
