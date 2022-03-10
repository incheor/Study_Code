# 데이터 가공

# 필터링 : filter, select

install.packages('dplyr')
library(dplyr)

# R studio 껐다가 켜니까 갑자기 작업 디렉토리가 변경돼서 작업 디렉토리 설정해줌
getwd()
setwd('C:/Souuces/StudyR/day05')
exam <- read.csv('C:/Souuces/StudyR/Data/csv_exam.csv')

# 해당 데이터세트 중에서 추출하기 
# %>%는 ctrl + shift + M하면 자동으로 완성됨
exam %>% filter(class == 1)
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(class == 1 | class == 3 | class == 5)

# or 조건으로 %in% 사용할 수도 있음
exam %>% filter(class %in% c(1, 3, 5))

# 연습
mpg <- as.data.frame(ggplot2::mpg)

displ_4 <- mpg %>% filter(displ <= 4)
displ_5 <- mpg %>% filter(displ >= 5)
mean(displ_4$hwy)
mean(displ_5$hwy)

audi <- mpg %>% filter(manufacturer == 'audi')
toyota <- mpg %>% filter(manufacturer == 'toyota')
mean(audi$cty)
mean(toyota$cty)

chevrolet_ford_honda <- mpg %>% filter(manufacturer == 'chevrolet' | manufacturer == 'ford' | manufacturer == 'honda')
mean(chevrolet_ford_honda$hwy)

# select도 가능
exam %>% select(class, math, english)
exam %>% select(-math, -english) # 특정 변수를 제외시킨 나머지를 조회할 때

# 다중 필터링 
exam %>% filter(class == 1) %>% select(english)
exam %>% select(id, math) %>% head

# 연습
mpg_new <- mpg %>% select(class, cty)
head(mpg_new)

class_suv <- mpg_new %>% filter(class == 'suv')
class_compact <- mpg_new %>% filter(class == 'compact')
mean(class_suv$cty)
mean(class_compact$cty)
