# Part1 : read.csv로 한글이 있는 자료 open
setwd('C:/Souuces/StudyR/day4/') # 작업 경로를 설정
dir() # 작업 경로에 필요한 파일이 있는지 확인
df = read.csv('./data_r/cust_order_data.csv', sep = '\t', encoding = 'ANSI', stringsAsFactor = TRUE)

## 미션 1 -1 : 데이터 읽기전 메모리 모두 제거
rm(list=ls()) # 메모리 모두 제거
ls() # 메모리 제거가 완료됐는지 확인
df = read.csv('./data_r/cust_order_data.csv', sep = '\t', encoding = 'ANSI', stringsAsFactor = TRUE)

## 미션 1 -2 : 총 데이터의 갯수와 변수의 셩격 확인
str(df) # 데이터의 변수(필드)의 성격 확인(문자, 숫자, 팩터 등)
head(df) # 위로 3개의 자료만 읽기
names(df) # 변수명(필드명)만 출력

## 미션 1 - 3 : 아래의 2개 필드 외에 나머지 변수에 대해 해석
## CUST_SERIAL_NO, SEX
### summary, table, plot, boxplot 등 활용하기

# Part2 : 자료 오류 확인 : 각 필드별로 불필요한 데이터가 포함되어 있는지 확인
str(df)

## 미션 2 -1 : 결측치 확인
sum(is.na(df)) # 해당 파일 전체 결측치 갯수 확인
i = NULL # 객체 i를 생성하고 NULL값 넣기
for(i in 1:length(df)){ # 반복문으로 자동화 : 필드별로 NA값이 있는지 확인
    print(names(df[i]))
    print(sum(is.na(df[, i])))
}

## 미션 2 -2 : 결측치 활용법 : 일정한 값을 결측치로 변경하고 결측치 제거 명령어를 이용해 행을 제거
tmp = subset(df, GOODS_NAME == '#NAME?') # subset으로 '#NAME?' 인 자료만 추출해서 확인
nrow(tmp) # 값이 #NAME? 의 레코드 갯수 확인 : 2123개
sum(is.na(df$GOODS_NAME)) # 현재 NA값 확인 : 0개
df$GOODS_NAME[df$GOODS_NAME == '#NAME?'] = NA # GOODS_NAME의 값이 #NAME? 인 값은 NA로 변경
sum(is.na(df$GOODS_NAME)) # 추가한 NA값 확인 : 2123개
df = df[complete.cases(df),] # NA값 제거
sum(is.na(df$GOODS_NAME)) # NA값 제거됐는지 확인 : 0개

### factor형에서는 값을 제거하더라도 levels의 값은 변경되지 않았음
### 라이브러리 설치 없이 쉽게 하는 방법은 
### 자료형을 character로 형변환했다가 factor로 변경하기
str(df) # 아직 GOODS_NAME levels에 '#NAME?' 가 있음
df$GOODS_NAME = as.factor(as.character(df$GOODS_NAME))
str(df) # 확인

### '*' 표시는 #NAME? 를 제거한 작업을 했을 때 남는거
### 자료의 모든 factor 자료형을 character로 변경하기
cnt = length(df)
for(i in 1:cnt){
    if(class(df[,i]) == 'factor'){
        df[,i] = as.character(df[,i])
    }
}
str(df) # 확인
### 다시 factor로 변환하고 '*'이 있는지 확인
cnt = length(df)
for(i in 1:cnt){
    if(class(df[,i]) == 'character'){
        df[,i] = as.factor(df[,i])
    }
}
str(df) # 확인

### 만약 실제로 '*' 이 있는 자료 제거는
### 방법 1 : * 표시가 있는 자료는 NA로 변경하고 NA값 제거
### 방법 2 : * 표시가 없는 자료만 병도로 제작
### 방벙 2가 쉽기 떄문에 방법 2로 진행함
### 우선 ' * ' 이 실제 값인지 제거되고 남은 값인지 확인
colNum=c(2, 3, 4, 6, 7)
for (i in colNum){
    print(paste('---------------', i, '번째컬럼: 컬럼명은 ', names(df[i])))
    print(unique(df[,i]))
    cat('\n')    # 한 줄 띄우기
}
### 확인결과 실제 '*' 값이 있음
### factor인 상태로는 값을 변경할 수 없음
### 형변환하기
cnt = length(df)
for(i in 1:cnt){
    if(class(df[,i]) == 'factor'){
        df[,i] = as.character(df[,i])
    }
}
str(df) # 형변환 됐는지 확인

colNum = c(2, 3, 4, 6, 7)
for(i in colNum){
    df2 = subset(df, df[, i] != '*')
}

### 위에 거는  이건 왜 안 되지
# cnt = length(df)
# for(i in 1:cnt){
#     df2 = subset(df, df[, i] != '*')
# }

colNum = c(2, 3, 4, 6, 7)
for(i in colNum){
    print(paste('-----', i, '번째 필드명은 ', names(df2[i])))
    print(unique(df2[, i]))
    cat('\n') # 한 줄 띄우기
}
str(df2)

unique(df2[,2]) # 제거가 됐는지 확인
table(df2[,2]) # 제거가 됐는지 확인

### 다시 형변환
cnt = length(df2)
for(i in 1:cnt){
    if(class(df2[,i]) == 'character'){
        df2[,i] = as.factor(df2[,i])
    }
}
str(df2) # 확인

# Part3 : 문자 자료를 날짜 자료로 변환 후 파생변후(년, 월, 일, 요일 등 제작)
# ORDER_DATE 필드를 character 또는 factor에서 date로 형변환
# date로 형변환하면 년, 월, 일, 요일 등을 쉽게 만들 수 있음

## 미션 3 - 1 : 문자에서 날짜로 형변환
## df2$ORDER_DATE 필드를 날짜형식으로 변경하고 tmp 변수에 할당하여 class로 type 확인
tmp = as.Date(df2$ORDER_DATE) # as.Date로 날짜형으로 변환
class(tmp) # 자료형 확인 : Date
df2$ORDER_DATE = tmp # df2$ORDER_DATE에 date형인 tmp할당
str(df2)

## 미션 3 -21 : Date 형식 자료 년 , 월, 일, 요일 제작
## lubridate 라이브러리 사용
install.packages('lubridate')
library(lubridate )

# year, month 파생변를 생성하고 거기에 값 할당
df2$year = year(df2$ORDER_DATE)
df2$month = month(df2$ORDER_DATE)
str(df2) # 마지막 2개 필드(파생변수) year, month가 생성된 것을 볼 수 있음

## 미션 3 - 2 : 성별 변환 : F는 female / M은 male로 변환해서 새로운 gender 필드 생성
unique(df2[,2]) # 레벨 확인
table(df2[2]) # 빈도수 확인
table(subset(df2[2] == '*')) # FALSE가 0 인 것을 확인 
df2$gender = ifelse(df2$SEX == 'F', 'female', 'male')

str(df2) # 확인
