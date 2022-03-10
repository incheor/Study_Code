# 그래프

getwd()
setwd('C:/Souuces/StudyR/day06')

mpg <- as.data.frame(ggplot2::mpg)

library(ggplot2)
install.packages('dplyr')
library(dplyr)

# 그래프 배경 설정하기
ggplot(data = mpg, aes(x = displ, y= hwy))

## 산점도
# 배경에 산점도 추가 : geom_point()
ggplot(data = mpg, aes(x = displ, y= hwy)) + geom_point()

# 축 범위를 조정하는 설정 추가
# x축 범위는 3 ~ 6 으로 설정, xlim(3, 6)
# y축 범위는 10 ~ 30 으로 설정, ylim(10, 30)
ggplot(data = mpg, aes(x = displ, y= hwy)) + 
  geom_point() + 
  xlim(3, 6) +
  ylim(10, 30)

# 연습
# mpg 데이터의 cty와 hwy간의 관계 확인
mpg <- as.data.frame(ggplot2::mpg)
ggplot(data = mpg, aes(x = cty, y= hwy)) + geom_point()

# midwest 데이터의 poptotal와 popasian간의 관계 확인
midwest <- as.data.frame(ggplot2::midwest)
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() + 
  xlim(0, 500000) + 
  ylim(0, 10000)

## 막대그래프
mpg <- as.data.frame(ggplot2::mpg)

df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

ggplot(data = df_mpg, aes(x = drv, y= mean_hwy)) + geom_col()

# 막대그래프 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y= mean_hwy)) + 
  geom_col()

## 빈도 막대그래프
# x축 범주 변수, y축 빈도(갯수)
ggplot(data = mpg, aes(x = drv)) +
  geom_bar()
ggplot(data = mpg, aes(x = hwy)) +
  geom_bar()

# 연습
suv_mpg <- mpg %>%
  filter(class == 'suv') %>% 
  group_by(manufacturer)%>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

ggplot(data = suv_mpg, aes(x = reorder(manufacturer, - mean_cty), y = mean_cty)) +
  geom_col()
