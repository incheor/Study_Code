# 데이터 수집 방법

## 파일 데이터 세트 읽기
library(readxl)
data <- read.csv('C:/Souuces/StudyR/Data/전라남도_목포시_장애인_복지시설_20210802.csv', header = T, fileEncoding = 'EUC-KR')
data





## 웹 크롤링
## 1. 크롤링 대상 URL 할당
## 2. 웹 문서 가져오기
## 3. 특정 태그의 데이터 추출
## 4. 데이터 정제
## 5. 데이터 프레임 만들기
install.packages('rvest')
install.packages('stringr')
library(rvest)
library(stringr)

# 1. 크롤링 대상 URL 할당
url <- "https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1"
url

# 2. 웹 문서 가져오기
usedCar <- read_html(url)
usedCar

# 3. 특정 태그의 데이터 추출
# nodes는 찾아가라
# 가져온 usedCar에서 css가 '.product-item' 인 것을 찾음
CarInfos <- html_nodes(usedCar, css = '.product-item')
head(CarInfos)

# 차량 명칭 추출
# text는 찾아와라
title_tmp <- html_nodes(CarInfos, css = '.tit.ellipsis')
title_tmp

title <- html_text(title_tmp)
head(title)

# 4. 데이터 정제
# 문자에서 문자 좌우의 공백 제거
title <- str_trim(title)
head(title)


## 다른 것도 해보기
# 차량 연식 추출
year_tmp <- html_nodes(CarInfos, css = '.mode-cell.year')
year_tmp

year <- html_text(year_tmp)
year

year <- str_trim(year)
year

year <- str_replace(year, '\n','')
head(year)


# 연료 구분 추출
fuel_tmp <- html_nodes(CarInfos, css = '.mode-cell.fuel')
fuel_tmp

fuel <- html_text(fuel_tmp)
fuel

fuel <- str_trim(fuel)
fuel

fuel <- str_replace(fuel, '\n','')
head(fuel)

# 주행거리 추출
km_tmp <- html_nodes(CarInfos, css = '.mode-cell.km')
km_tmp

km <- html_text(km_tmp)
km

km <- str_trim(km)
km

km <- str_replace(km, '\n','')
head(km)

# 판매가격 추출
price_tmp <- html_nodes(CarInfos, css = '.mode-cell.price')
price_tmp

price <- html_text(price_tmp)
price

price <- str_trim(price)
price

price <- str_replace(price, '\n','')
head(price)


# 제조사 추출
maker = c()
maker

title

# str_split을 활용해 문자열 분리
for(i in 1:length(title)){
  maker <- c(maker, unlist(str_split(title[i], ' '))[1]) 
}

head(maker)


# 5. 데이터 프레임 만들기
usedcars <- data.frame(title, year, fuel, km, price, maker)
View(usedcars)


# 4. 데이터 정제
# 문자형을 형변환 해주기
# km 자료를 숫자로 자료형 변환
usedcars$km

usedcars$km <- gsub('만km', '0000', usedcars$km) # 문자열 변환(만 -> 10000)
usedcars$km <- gsub('천km', '000', usedcars$km)
usedcars$km <- gsub('km', '', usedcars$km)
usedcars$km <- gsub('미등록', '', usedcars$km)
usedcars$km <- as.numeric(usedcars$km) # 숫자형으로 변경

usedcars$km

# price 자료를 숫자형으로 변환
usedcars$price

usedcars$price <- gsub('만원', '', usedcars$price)
usedcars$price <- gsub('계약', '', usedcars$price)
usedcars$price <- gsub('팔림', '', usedcars$price)
usedcars$price <- gsub('금융리스', '', usedcars$price)
usedcars$price <- gsub(',', '', usedcars$price)
usedcars$price <- as.numeric(usedcars$price)

usedcars$price


# 웹 크롤링 자료를 파일로 저장하기
write.csv(usedcars, 'C:/Souuces/StudyR/Data/usedcars_new.csv')





# 오픈 API
# 1. 제공 웹사이트에 접속 및 로그인
# 2. 활용신청 및 개발계정 API키 신청
# 3. API키 신청이 승인되면 확인
# 4. 접속을 위한 웹 URL 및 요청변수 확인
# 5. 오픈 API를 이용해 자료 요청
# 6. 데이터 프레임으로 만들기
install.packages('XML')
library(XML)

# 웹 사이트 URL 설정
api_url <- "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"

# 승인받은 인증키 설정
service_key <- "nDqa2ug4uPizctwIytKqxYAE5uMtyH0HD4y0vu4ZFXMZYvRABkjqBbJlMQWJG%2Fgug3hwTZkP2UFI1S1zqwbm2w%3D%3D"

# 요청변수 등록
numOfRows <- '30'
sidoName <- '경기'

# 한글을 웹 URL 코드화
sidoName <- URLencode(iconv(sidoName, to = 'UTF-8'))
sidoName

searchCondition <- 'DAILY'

# URL 주소를 공백없이 모두 묶기
# paste와 paste0의 차이
# paste : 공백을 구분자로 묶기
# paste0 : 구분자(공백) 없이 모두 묶기
open_api_url <- paste0(api_url, "?serviceKey=", service_key,
                       "&numOfRows=", numOfRows,
                       "&sidoName=", sidoName,
                       "&searchCondition=", searchCondition)

open_api_url

# 오픈 API로 자료 요청하기
# XML 형식으로 자료 가져오기
raw.data <- xmlTreeParse(open_api_url,
                         useInternalNodes = TRUE,
                         encoding = 'utf-8')
raw.data

# XML형식에서 데이터 프레임 형식으로 변환
# </item> 태그별로 데이터를 구분해주기
air_pollution <- xmlToDataFrame(getNodeSet(raw.data, " //item"))
air_pollution

View(air_pollution)

# 사용할 필드 분리
# subset() : 데이터 프레임 내에서 검색조건에 맞는 컬럼(필드)들만 분리
air_pollution <- subset(air_pollution,
                        select = c(dataTime,
                                   stationName,
                                   so2Value,
                                   coValue,
                                   o3Value,
                                   no2Value,
                                   pm10Value))
View(air_pollution)

# 오픈 API 자료를 파일로  저장하기
write.csv(air_pollution, 'C:/Souuces/StudyR/Data/air_pollution_new.csv')
