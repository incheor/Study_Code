# Part1 : read.csv로 한글이 있는 자료 open
setwd('C:/Souuces/StudyR/day4/') # 작업 경로를 설정
dir() # 작업 경로에 필요한 파일이 있는지 확인
df = read.csv('./data_r/cust_order_data.csv', sep = '\t', encoding = 'ANSI', stringsAsFactor = TRUE)

## 미션 1 -1 : 데이터 읽기전 메모리 모두 제거
rm(list=ls()) # 메모리 모두 제거
ls() # 메모리 제거가 완료됐는지 확인
df = read.csv('./data_r/cust_order_data.csv', sep = '\t', encoding = 'ANSI', stringsAsFactor = TRUE)

df = df[df$SEX != "*",] # 데이터에 값이 아닌 *가 들어가 있는 경우 분리
head(df,10)
str(df)

### 성별 구매 건수
# 구매일자, 성별, 구매 건수만 추출하여 별도의 데이터 프레임을 만듬
sex1 = subset(df, select=c(ORDER_DATE,SEX,QTY))
str(sex1)

# 구매일자에서 월 정보만 추출하기 위한 lubridate 라이브러리를 설치
install.packages('lubridate')
library(lubridate)

# ORDER_DATE 열에 저장되어 있는 날짜를 이용하여
# month 함수로 월만 추출해서 month라는 새로운 열을 추가 
sex2 = cbind(sex1, month=month(sex1$ORDER_DATE))
head(sex2,5)
str(sex2)

# 데이터 조작을 위해 reshape2 라이브러리를 설치
install.packages('reshape2')
library(reshape2)

# 성별로 구분하여 월별 구매 건수의 총합을 구해서 확인
dcast(sex2, SEX ~ month,value.var='QTY',sum)

# F나 M 대신 female, male이라고 표시하기 위해서 변환 함수를 
# 만들어서 적용하여 gender라는 열을 추가
sex2$gender = ifelse(sex2$SEX == 'F', 'female', 'male')
head(sex2)
str(sex2)

install.packages('ggplot2')
library(ggplot2)
# 성별 별로 월별 구매 건수를 누적 막대 그래프로 표시
qplot(month,data=sex2,geom='bar',fill=gender)

# 성별 별로 월별 구매 건수를 별도의 막대 그래프로 표시
ggplot(sex2,aes(month))+geom_bar()+facet_wrap(~gender)

### 연령대 구매 건수
# 구매일자, 나이, 구매 건수만 추출하여 별도의 데이터 프레임을 만
Age1 = subset(df, select=c(ORDER_DATE,AGE,QTY))
head(Age1)
str(Age1)

# ORDER_DATE 열에 저장되어 있는 날짜를 이용하여
# month 함수로 월만 추출해서 month 라는 새로운 열을 추가
Age2 = cbind(Age1, month=month(Age1$ORDER_DATE))

# 연령별로 구분하여 월별 구매 건수의 총합을 구해서 확인
Dcast(Age2, AGE~month, value.var=＂QTY＂,sum)

# 그래프에 표시할 때, 10대, 20대, 30대와 같이 표시될 수 있도록 
# 나이에 “대＂를 붙여서 ages라는 열을 추가
Age2 <- cbind(Age2, ages=paste(Age2$AGE,"대"))
str(Age2) # 확인

# 연령 별로 월별 구매 건수를 누적 막대 그래프로 표시
qplot(month,data=Age2,geom="bar",fill=ages)

# 연령 별로 월별 구매 건수를 별도의 막대 그래프로 표시
ggplot(Age2,aes(month))+geom_bar()+facet_wrap(~ages)

### 연령대/성별 구매 건수
# 구매일자, 성별, 나이, 구매 건수만 추출하여 별도의 데이터 프레임을 만들기
sexage1 <- subset(df,select=c(ORDER_DATE,SEX,AGE,QTY))
head(sexage1)

# ddply() 함수를 사용하여 날짜, 성별, 나이로 그룹을 지어 구매 수량을 합쳐서 확인
library(plyr)

sexage2 <- ddply(sexage1, .(ORDER_DATE,SEX,AGE), summarize, Sum_F=sum(QTY))
head(sexage2)

# month() 함수로 월만 추출하여 month 열을 추가하고
# ages 열에는 나이에 “대＂를 붙여서 추가
sexage3 <- cbind(sexage2, month=month(sexage2$ORDER_DATE))
sexage3 <- cbind(sexage3, ages=paste(sexage3$AGE,"대"))
head(sexage3)

# 성별과 연령을 기준으로 월별 구매 건수를 별도의 막대 그래프로 표시
ggplot(sexage3,aes(month))+geom_bar()+facet_wrap(~SEX+ages)

### 월별 고객단위 구매금액
# 구매일자, 고객 번호, 구매 금액만 추출하여 별도의 데이터 프레임을 만
cust1 = subset(df, select=c(ORDER_DATE,CUST_SERIAL_NO,PRICE))
head(cust1)

# month() 함수로 월만 추출하여 month 열을 추가
cust2 = cbind(cust1, month=month(cust1$ORDER_DATE))
nrow(cust2)

# ddply() 함수를 사용하여 고객 번호와 월로 그룹을 지어 구매 금액을 합쳐서 확인
cust3 = ddply(cust2, .(CUST_SERIAL_NO,month),summarize,Sum_F=sum(PRICE))
nrow(cust3)
head(cust3)

# aggregate() 함수를 이용하여 고객 번호와 월을 기준으로 구매 금액을 합침
df2 = cbind(df, month=month(df$ORDER_DATE))
aggdata = aggregate(PRICE~CUST_SERIAL_NO+month,data=df2,sum)

# 그래프의 범례로 사용하기 위해 월에 “월＂을 붙여서 real_month라는 열을 추가
aggdata = cbind(aggdata, real_month=paste(aggdata$month,"월"))
head(aggdata)

# 월별 총 구매 금액의 
# 최대값과 최소값, 평균값 등을 비교하기 위해 
# 상자 차트로 표시
p = ggplot(aggdata, aes(real_month,PRICE))
p+geom_boxplot(aes(fill=real_month))

### 500,000원 미만으로 Filter 
# 구매 금액의 총합이 50만원 미만인 고객을 추출하여 고객 수를 확인
cust4 = subset(cust3,Sum_F<500000)
nrow(cust4)

# 월별 총 구매 금액이 50만원 미만인 구매에 대해서 
# 최대값과 최소값, 평균값 등을 
# 비교하기 위해 상자 차트로 표시
p = ggplot(subset(aggdata,PRICE<500000),aes(real_month,PRICE))
p+geom_boxplot(aes(fill=real_month))

### 요일별 구매 금액 합계
# 구매 요일, 구매 건수만 추출하여 별도의 데이터 프레임을 만들기
day1 = subset(df,select=c(ORDER_WEEKDAY,PRICE))
head(day1)

# ddply() 함수를 사용하여 요일별로 구매 금액을 합쳐서 확인
day2 = ddply(day1,.(ORDER_WEEKDAY),summarize,Sum_F=sum(as.numeric(PRICE)))
day2

# ddply() 함수를 사용하여 
# 요일별로 구매 금액을 합친 결과를
# aggdata.summary에 저장
aggdata.summary = ddply(day1,.(ORDER_WEEKDAY),summarize,Sum_F=sum(as.numeric(PRICE)))

# 그래프에 출력될 때 자동으로 정렬해서 출력되도록 
# 요일 앞에 1부터 7까지의 숫자를 붙이는 함수를 만들어서 적용
changeRday = function(x) { if (length(grep(x[1],"월"))>0){return("1_월")}
else if (length(grep(x[1],"화"))>0){return("2_화")}
else if (length(grep(x[1],"수"))>0){return("3_수")}
else if (length(grep(x[1],"목"))>0){return("4_목")}
else if (length(grep(x[1],"금"))>0){return("5_금")}
else if (length(grep(x[1],"토"))>0){return("6_토")}
else if (length(grep(x[1],"일"))>0){return("7_일")}}
aggdata.summary$rday = apply(aggdata.summary,1,changeRday)
aggdata.summary

# 요일별 구매 금액의 총합을 막대 그래프로 표시
ggplot(aggdata.summary,aes(rday,Sum_F))+geom_bar(stat="identity")

### 요일별 구매 상품 수
# ddply() 함수를 사용하여
# 요일별로 구매 수량을 합친 결과를 dayamt2에저장하고
# 요일 이름 변경 함수를 적용하여 rday 열을 추가
dayamt1 = subset(df,select=c(ORDER_WEEKDAY,QTY))
dayamt2 = ddply(dayamt1,.(ORDER_WEEKDAY),summarize,Sum_F=sum(QTY))
dayamt2$rday = apply(dayamt2,1,changeRday)
Dayamt2

# 요일별 총 구매 수량이
# 2개를 초과하는 구매에 대해서
# 최대값과 최소값, 평균값 등을
# 비교하기 위해 상자 차트로 표시
p = ggplot(subset(df,QTY>2),aes(ORDER_WEEKDAY,QTY))
p + geom_boxplot(aes(fill=ORDER_WEEKDAY))

###### 그룹별 구매 패턴 분석
### 전체 고객의 구매수량 상위 100개의 세 분류 상품에 대하여
# wordcloud 라이브러리로 표현
# 상품 분류 코드와 구매 수량 데이터만 추출한
# 다음 동일한 상품 분류 코드에 대한 누적 구매수량을 구하기
dgroup1 = subset(df,select=c(LGROUP,MGROUP,SGROUP,DGROUP,QTY,GOODS_NAME))
head(dgroup1)
dgroup2 = ddply(dgroup1, .(LGROUP,MGROUP,SGROUP,DGROUP,GOODS_NAME),summarize,Sum_F=sum(QTY))
head(dgroup2)
nrow(dgroup2)

# 조인을 하기 위해 4개의 상품 분류 코드를
# 하나의 문자열로 합친 다음 LMSD_ICODE 열에 저장
dgroup2 = cbind(dgroup2,LMSD_ICODE=paste(dgroup2$LGROUP,"|",dgroup2$MGROUP,"|",dgroup2$SGROUP,"|",dgroup2$DGROUP))

# 상품 분류 코드에 따른 분류 이름이 저장된 CSV 파일을 읽은 다음
# 역시 조인을 하기 위해 4개의 상품 분류 코드를
# 하나의 문자열로 합친 다음 LMSD_ICODE 열에 저장
vhd = cbind(dgroup2,LMSD_ICODE=paste(dgroup2$LGROUP,"|",dgroup2$MGROUP,"|",dgroup2$SGROUP,"|",dgroup2$DGROUP))

# 두 개의 데이터 프레임을 
# LMSD_ICODE 열을 기준으로 조인하여 합치고 
# 구매수량 기준으로 내림차순 정렬
vhd2 = subset(vhd,select=c(LMSD_ICODE,GOODS_NAME))
dgroup2 = merge(x=dgroup2,y=vhd2,by='LMSD_ICODE',all=TRUE)
dgroup3 = dgroup2[c(order(-dgroup2$Sum_F)),]

# dgroup3에서 상위 100개의 합계만 추출하여 별도의 벡터로 만들기
vec1 = c()
for(i in 1:100){
    print(i)
    print(dgroup3$Sum_F[i])
    vec1 = c(vec1,as.numeric((dgroup3$Sum_F[i])))
}
head(dgroup2, 100)
head(dgroup3, 100)

# wordcloud 라이브러리를 이용하여 상위 100개의 상품 세 분류 이름을 시각화
install.packages('wordcloud')
library(wordcloud)
palete = brewer.pal(9,"Set1")
wordcloud(dgroup3$GOODS_NAME.y,freq=vec1,scale=c(5,1),rot.per=0.25,min.freq=2,random.order=F,random.color=T,colors=palete)
