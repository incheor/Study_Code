install.packages('XML')
library(XML)

# 승인받은 인증키 설정
service_key <- 'nDqa2ug4uPizctwIytKqxYAE5uMtyH0HD4y0vu4ZFXMZYvRABkjqBbJlMQWJG%2Fgug3hwTZkP2UFI1S1zqwbm2w%3D%3D'

# 웹 사이트 URL 설정
api_url <- 'http://apis.data.go.kr/B552584/EvCharger/getChargerInfo'

# 요청변수 등록
# 부산 지역 코드
zcode = '26'

# URL 주소를 공백없이 모두 묶기
open_api_url <- paste0(api_url, "?serviceKey=", service_key,
                       "&zcode=", zcode)

open_api_url

# 오픈 API로 자료 요청하기
# XML 형식으로 자료 가져오기
raw.data <- xmlTreeParse(open_api_url,
                         useInternalNodes = TRUE,
                         encoding = 'utf-8')
raw.data

# XML형식에서 데이터 프레임 형식으로 변환
# </item> 태그별로 데이터를 구분해주기
EV_charging_station <- xmlToDataFrame(getNodeSet(raw.data, " //item"))
EV_charging_station

View(EV_charging_station)

# 사용할 필드 분리
EV_charging_station <- subset(EV_charging_station,
                              select = c(statNm,
                                         addr,
                                         lat,
                                         lng,
                                         useTime))
View(EV_charging_station)

# 오픈 API 자료를 파일로  저장하기
write.csv(EV_charging_station, 'C:/Souuces/StudyR/Data/EV_charging_station_new.csv')

bs_ECS <- read.csv('C:/Souuces/StudyR/Data/EV_charging_station_new.csv', header = T)

# 부산의 시간대 별 충전소 현황
table(bs_ECS$useTime)
table(is.na(bs_ECS))

library(dplyr)
library(ggplot2)

ggplot(data = bs_ECS, aes(x = useTime)) +
  geom_bar()

# 부산시 구 별 24시간 이용 가능한 전기차 충전소 갯수 현황
bs_ECS$addr

bs_ECS$addr <- substr(bs_ECS$addr, start = 6, stop = 9)
bs_ECS$addr

bs_ECS_new <- bs_ECS %>% 
  filter(bs_ECS$addr == '24시간 이용가능')

ggplot(data = bs_ECS_new, aes(x = bs_ECS$addr)) +
  geom_bar()
