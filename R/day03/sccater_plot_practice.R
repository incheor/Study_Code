mtcars
str(mtcars)
plot(mtcars)

# 1, 3, 5, 6번 필드의 데이터만 사용함(연비, 배기량, 리어 엑슬 기어비, 중량)
plot(mtcars[, c(1, 3, 5, 6)])

# 피어슨 상관계수를 써서 확인
cor(mtcars[, c(1, 3, 5, 6)])

# 다중공선성은 독립변수들끼리 상관도가 높은 경우임
# 다중공선성은 VIF(분산팽창계수)로 10이상 나오는 것을 의미하고 5가 넘으면 주의가 필요함
# 만약 다중공선성의 문제가 발생한 경우 x값을 제거하거나 변경하며 상관도를 낮춰야함

# 머신러닝(기계학습)이란 독립변수들과 종속변수의 분석을 통한 예측

# 이러한 두 변수(x, y값)간의 상관관계는 말 그대로 선형적인 증가와 감소의 상호관계이며
# 직접적인 영향을 주는 인과관계를 의미하지는 않음

# PerformanceAnalytics 라이브러리를 써서
# mtcars의 변수들간의 상관도 보기
install.packages('PerformanceAnalytics')
library(PerformanceAnalytics)
chart.Correlation(mtcars, histogram = TRUE, pch = 19) # 숫자만 가능


boxplot(mtcars$mpg ~ mtcars$gear)
plot((mtcars$mpg ~ mtcars$gear))
cor(mtcars$mpg , mtcars$gear)

tmp = scale(mtcars)
summary(tmp)
boxplot(tmp)