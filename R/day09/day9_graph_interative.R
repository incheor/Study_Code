# 인터랙티브 그래프

getwd()
setwd('C:/Souuces/StudyR/day09')


# 인터랙티브 그래프 만들어주는 라이브러리
install.packages('plotly')
library(plotly)

library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) +
  geom_point()

## 차이 비교해보기
p
ggplotly(p)

## 다이아몬드 데이터세트로 또 해보기
diamonds <- as.data.frame(ggplot2::diamonds)

p <- ggplot(data = diamonds, aes(x = cut, col = clarity)) +
  geom_bar(position = 'dodge')

ggplotly(p)



# 시계열 그래프
install.packages('dygraphs')
library(dygraphs)

economics = ggplot2::economics
head(economics)

## 시간 순서 속성을 지니는 xts  데이터 타입으로 변경
library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

dygraph(eco)

## 그래프에서 날짜 범위 지정할 수 있음
library(dplyr)
dygraph(eco) %>% dyRangeSelector()



# 여러값 표현
## 저축률
eco_a <- xts(economics$psavert, order.by = economics$date)

## 실업자 수
eco_b <- xts(economics$unemploy / 1000, order.by = economics$date)

## 합치기
eco2 <- cbind(eco_a, eco_b) # 데이터 결함
colnames(eco2) <- c('psavert', 'unemploy') # 변수명 변경
head(eco2)

## 그래프 만들기
dygraph(eco2) %>% dyRangeSelector()
