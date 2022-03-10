# 지도 시각화

# 미국 주별 강력 범죄율 단계 구분 지도 시각화

install.packages('ggiraphExtra')
library(ggiraphExtra)

## 미국 주별 범죄 데이터 준비하기
str(USArrests)
# 인덱스 번호는 없고 주 이름이 있음
head(USArrests)

# tibble : dataframe 생성할 때 factor로 인식하는 것을 개선한 라이브러리
library(tibble)

# 행 이름을 state 변수로 바꾸고 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = 'state')
# 이제 주 이름 필드에 변수명이 생기고 그 왼쪽에 인덱스 번호 생김
head(crime)

# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <- tolower(crime$state)
str(crime)

## 미국 주 지도 데이터 준비하기
library(ggplot2)
states_map <- map_data('state')
# 지도를 그릴 때는 주소나 위경도가 필요함
# 여기서는 위경도(long, lat)
str(states_map)

## 단계 구분 지도 만들기
ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색까로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map) # 지도 데이터

## 인터랙티브 단계 구분 지도 만들기
# 데이터가 변하지는 않고 약간 더 예쁘게 나옴
ggChoropleth(data = crime, # 지도에 표현할 데이터
             aes(fill = Murder, # 색까로 표현할 변수
                 map_id = state), # 지역 기준 변수
             map = states_map, # 지도 데이터
             interactive = T) # 인터랙티브


# 대한민국 시도별 결핵 환자 수 지도
install.packages('stringi')

install.packages('dectools')
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

## 대한민국 시도별 인구 데이터 준비
# UTF-8로는 못 써서 changeCode()를 사용해서 CP949로 변환해줘야 함
library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

str(changeCode(korpop1))

## 인터랙티브 단계 구분 지도 만들기
# 한글이 깨져서 나와서 이 코드 추가
korpop1$name <- iconv(korpop1$name, "UTF-8","CP949")

ggChoropleth(data = korpop1, # 지도에 표현할 데이터
             aes(fill = pop, # 색깔로 표현할 변수
                 map_id = code, # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1, # 지도 데이터
             interactive = T) # 인터랙티브

## 대한민국 시도별 결핵 환자 수 데이터 
str(changeCode(tbc))

## 인터랙티브 단계 구분 지도 만들기
tbc$name <- iconv(tbc$name, "UTF-8","CP949")
ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)