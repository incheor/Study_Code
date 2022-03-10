# 데이터 전처리

getwd() # get work directory : 현재 작업 디렉토리 보기
setwd('C:/Souuces/StudyR/day2') # set work directory : 해당 경로를 작업 디렉토리로 설정
dir() # 현재 디랙토리의 자료들 보기
fileName = '전국무인교통단속카메라표준데이터.csv'
df = read.csv(fileName) # 파일 읽기

head(df) # 데이터 샘플 보기
str(df) # 구조 확인, 데이터 프레임이네

# 인덱싱 활용해서 데이터 확인해보기
table(df$시도명) # 테이블로 빈도수 확인

# subset : 설정하는 조건에 맞는 벡터, 매트릭스 혹은 데이터 프레임을 반환
# 시도명 코드가 01인 자료 좀 보자
subset(df, 시도명 == '01')
tmp = subset(df, 시도명 == '01') # 분리한 데이터를 tmp변수에 저장
str(tmp) # tmp의 구조 확인, 데이터 프레임이네
summary(tmp) # tmp 데이터의 기술 확인

# 아래 2개의 코드는 결과가 비슷하다
# 값들의 빈도수 확인하기
summary(factor(tmp$시도명))
table(tmp$시도명)
# 아래 2개의 코드는 결과가 비슷하다
# 중복값들을 제거하고 확인하기
levels(factor(tmp$시도명))
unique(tmp$시도명)

# 다른 예시 시도명 코드가 03인 경우
subset(df, 시도명 == '03')
tmp = subset(df, 시도명 == '03')
## 이번에는 '소재지도로명주소'로 보자
summary(factor(tmp$소재지도로명주소))
table(tmp$소재지도로명주소)
unique(tmp$소재지도로명주소)

# 1.  자료형 변환
## 변수는 필드라고 생각하면 됨
## 1. 문자를 factor로 변환 : 시도명, 시군구명, 도로종류, 도로노선명
## 2. 숫자를 factor로 변환하는 파생변수 : 설치연도, 제한속도
## 파생변수는 그냥 없는 변수를 만들어서 추가

df$시도명 = factor(df$시도명) # df[,2] = factor(df[,2]) 이것도 가능
df$시군구명 = factor(df$시군구명)
df$도로종류= factor(df$도로종류)
df$도로노선명= factor(df$도로노선명)
summary(df$시도명) # 이제 summary()하면 값의 빈도수를 볼 수 있다
levels(df[,2]) # 2번째 열인 시도명 열의 값을 보자

df$설치연도factor = factor(df$설치연도) # df$설치연도factor가 파생변수
str(df) # 가장 밑에 추가됨을 확인할 수 있다
df[, 25] = factor(df$제한속도)
str(df)

summary(df) # 설치연도에 NA 값이 보이기 시작
table(df[,24])

# 2. 컬럼명 정리
names(df)[1] = '카메라Num' # 필드명 바꾸기
names(df)[25] = '제한속도factor'
names(df)[1] = paste(names(df)[1], '-bu', sep = ' ') # 문자열 연결
names(df) # 필드명 보면 바꼈다

# 3. 필요한 컬럼만 모아서 별도의 데이터셋 제작
## 1. 불필요한 컬럼을 제거함으로서 수행속도를 높임
## 2. 분석하고자 하는 내용에 맞게 새로운 데이터 프레임 구성
df1 = df[ , c(2, 3, 4, 7, 11, 13, 14, 16)] # 필요한 컬럼만 가져오기
df2 = df[ , c(10, 11, 13, 14)]
names(df2) # 확인

# 4. 조건에 맞는 자료만 필터링 해서 새로운 데이터셋 제작
# 다른 라이브러리들이 많지만 일단은 subset() 으로 해보기

# 미션1 : 단속 필드를 unique하게 받아오기
unique(df1$단속구분)

# subset으로 단속구분이 1인 자료만 필터링
subset(df1, 단속구분 == '1')

# subset으로 제한속도가 50인 자료만 필터링
subset(df1, 제한속도 == 50)

# subse으로 단속구분이 1 제외하고 필터링
subset(df1, 단속구분 != '1')

# subset으로 단속구분이 1이면서 (&) 시군구명이 '경기도'인 자료
subset(df1, 단속구분 == '1' & 시도명 == '경기도')
table(df1$시군구명)

# 5. 자료셋을 새로 제작해서 csv로 저장하기
sido = unique(df1$시도명) # 시도명 중 중복값을 제거하고 sido변수에 저장
sido
cnt = length(sido) # sido의 행의 갯수

# 아래말고 이렇게도 할 수 있음
# select = '경기도'
# tmp = subset(df1, 시도명 == select)

# for문 돌리기
for(index in 1:cnt){
tmp = subset(df1, 시도명 == sido[index])

fileName = paste(sido[index], '.csv', sep = ' ')
write.csv(tmp, fileName) # csv 파일로 만들기
}

# 복습해보기
# R 메모리 변수 모두 삭제
# rm(list=ls())
getwd() # get work directory : 현재 작업 디렉토리 보기
setwd('C:/Souuces/StudyR/day2') # set work directory : 해당 경로를 작업 디렉토리로 설정
dir() # 현재 디랙토리의 자료들 보기

# 데이터가 다 날라가는 것을 방지하기 위해서
# 계속 메모리 지우고 다시 만들고 해주자
# R 메모리 변수 모두 삭제
df = read.csv(dir()[3], stringsAsFactors = TRUE) # 파일을 읽어올 때부터 문자를 factor로 불러오기
df1 = df[ , c(1:9)] # df 데이터 중 1 ~ 9번째 열을 df1에 저장
write.csv(df1, '작업자료.csv') # csv 파일로 만들기

# rm(list=ls())
dir()
df = read.csv(dir()[3], stringsAsFactors = TRUE)
df = df[ , -1]
str(df)

# NA값 확인
summary(df)
sum(is.na(df[,7]))
colName = names(df)
cnt = length(colName)
for(i in 1:cnt){
    print(colName[i])
    print(sum(is.na(df[,i])))
}

# 시각화로 missing data 확인해보기
library(naniar)
naniar::miss_case_summary(df) # case : 행 기준
naniar::iss_var_summary(df) # var : 열 기준
naniar::vis_miss(df)

library(VIM)
library(Amelia)
missmap(df)
# 현재 작업 경로에 현재 열려있는 plot창을 이미지 파일로 저장
savePlot('무인카메라결측치', type = 'png')

# 나중에 결측치(NA)를 처리