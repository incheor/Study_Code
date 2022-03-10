install.packages('reshape2')
library(reshape2)

# tips 데이터셋 불러오기
tips

# 자료 파악: 해당 자료의 변수(필드)의 성격과 해석
head(tips) # tips 데이터의 샘플 보기
str(tips) # tips 데이터의 구조: 데이터 프레임
class(tips) # tips 데이터의 자료형: 데이터 프레임
# totall_bill: 전체 식비 # tip: 팁 비용 # sex: 성별 # smoker: 흡연여부 # day: 요일 # time: 점심, 저녁 # size: 방문 인원

# NA값의 갯수 보기
sum(is.na(tips))

# 가설과 검증
# 영(0)가설, 귀무가설: 가설의 시작
# x값(독립변수)이 바뀌어도 y값(종속변수, 레이블, 결과값)에는 영향을 미치지 않을 것이다라고 가정
## 검증을 통해 결과가 같다 --> 귀무가설 채택 / 결과가 다르다 --> 귀무가설 기각, 대립가설 채택

# 가설검증 하기 전에 연습하기

# 빈도수를 테이블로 보기, 도수분포표
for(i in 3:7){
    print(names(tips[i]))
    print(table(tips[,i]))
}

# 만약 산점도의 직선의 기울기가 양이면 양의 상관관계, 음이면 음의 상관관계, 0이면 관계가 없다고 볼 수 있음
plot(tips)

# +1일 경우 완전 양의 상관관계, -1일 경우 완전 음의 상관계라고 함
# 피어슨 상관계수를 써서 (R이서는 숫자만 사용가능, 파이썬은 문자도 가능)
# 전체 식비와 팁 지불액과 방문 인원의 상관관계 보기
cor(tips[, c(1, 2, 7)])

# 다중공선성은 독립변수들끼리 상관도가 높은 경우임
# 다중공선성은 VIF(분산팽창계수)로 10이상 나오는 것을 의미하고 5가 넘으면 주의가 필요함
# 만약 다중공선성의 문제가 발생한 경우 x값을 제거하거나 변경하며 상관도를 낮춰야함

# 머신러닝(기계학습)이란 독립변수들과 종속변수의 분석을 통한 예측

# 이러한 두 변수(x, y값)간의 상관관계는 말 그대로 선형적인 증가와 감소의 상호관계이며
# 직접적인 영향을 주는 인과관계를 의미하지는 않음

# 점심과 저녁을 기준으로 데이터를 분리
lun = subset(tips, time == 'Lunch')
din = subset(tips, time == 'Dinner')

# 점심저녁 각각의 합계와 분리한 데이터를 분석
table(tips$time) # 저녁이 점심의 2배
table(lun$day) # 토, 일요일에는 0명
table(din$day)

# 점심저녁의 전체 식비, 팁 비용, 방문 인원의 평균
colMeans(lun[c('total_bill', 'tip', 'size')])
colMeans(din[c('total_bill', 'tip', 'size')])
 
 # 점심저녁의 전체 식비, 팁 비용, 방문 인원의 합계
colSums(lun[c('total_bill', 'tip', 'size')])
colSums(din[c('total_bill', 'tip', 'size')])

# 점심저녁의 팁 비용을 차트로 보기
par(mfrow = c(3 , 1))
plot(tips$tip)
plot(lun$tip)
plot(din$tip)

# 저녁의 팁 비용 중 튀는 값 조사해보기
tmp = subset(lun, tips$tip >= 4)
summary(lun) # 아래와 비교해보기
summary(tmp)

# 금요일 방문객이 팁 비용을 많이 지불하는지 보기
tmp = subset(tips, tips$day == 'Fri')
summary(tmp)
table(tmp$size) 

# 1번 가설: 성별에 따른 tips의 지불 금액은 같다
## 여기서는 성별은 독립변수, tips는 종속변수

# 성별에 따른 팁 비용의 차이를 확인해보기
table(tips$sex) # Male의 방문인원이 2배 많음
s_f = subset(tips, tips$sex == 'Female')
s_m = subset(tips, tips$sex == 'Male')
summary(s_f)
summary(s_m)

# 성별 팁 지불액 차트
par(mfrow = c(2 , 1))
plot(s_f$tip, main = 'female - tips')
plot(s_m$tip, main = 'male - tips')

# 성별 방문 인원 차트
par(mfrow = c(2 , 1))
plot(s_f$size, main = 'female - size')
plot(s_m$size, main = 'male - size')


# 전체 식비(x값)와 팁 지불액(y값) 관계보기
plot(tips[,1], tips[,2])

# 방문 인원(x값)관 전체 식비(y값) 관계보기
plot(tips[,7], tips[,1])

# 전체 식비, 팁 지불액, 방문 인원 차트 보기
colNum = c(1, 2, 7)
par(mfrow = c(3, 1))
for(i in colNum){
    plot(tips[,i], main = names(tips)[i])
}

plot(tips[, c(1, 2, 7)])

# PerformanceAnalytics 라이브러리를 써서 (숫자만 가능)
# 전체 식비와 팁 지불액과 방문 인원의 상관도를 차트로 보기
install.packages('PerformanceAnalytics')
library(PerformanceAnalytics)
chart.Correlation(tips[, c(1, 2, 7)], histogram = TRUE, pch = 19)

# 요일별 분석
# 금요일
tmp = subset(tips, day == 'Fri')
par(mfrow = c(2, 2))
boxplot(tip ~ size, data = tmp)
boxplot(tip ~ sex, data = tmp)
boxplot(tip ~ smoker, data = tmp)
boxplot(tip ~ time, data = tmp)

# 토요일
tmp = subset(tips, day == 'Sat')
par(mfrow = c(2, 2))
boxplot(tip ~ size, data = tmp)
boxplot(tip ~ sex, data = tmp)
boxplot(tip ~ smoker, data = tmp)
boxplot(tip ~ time, data = tmp)

boxplot(tips$tip)
tt = subset(tips, tip < 5)
summary(tt)
boxplot(tt$tip)

str(tt)
boxplot(tip ~ day, data = tt)

tmp = subset(tips, day == 'Fri')
par(mfrow = c(2, 2))
boxplot(tip ~ size, data = tmp)
boxplot(tip ~ sex, data = tmp)
boxplot(tip ~ smoker, data = tmp)
boxplot(tip ~ time, data = tmp)

tmp = scale(tips)
summary(tmp)
boxplot(tmp)
