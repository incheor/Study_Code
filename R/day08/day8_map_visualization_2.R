# 지도 시각화 연습


# 준비
library(tibble)
library(ggplot2)
install.packages('stringi')
install.packages('dectools')
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)
library(dplyr)
library(ggiraphExtra)
install.packages('plotly') # 인터랙티프 그래프
library(plotly)

korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop1$name <- iconv(korpop1$name, "UTF-8","CP949")
str(changeCode(korpop1))

tbc$name <- iconv(tbc$name, "UTF-8","CP949")
str(changeCode(tbc))


####### 지역별 인구 수
korpop1
str(changeCode(korpop1))

ggplot(data = korpop1, aes(x = reorder(name, -pop), y = pop)) +
  geom_col()



####### 지역별 가구 수 분석
korpop1
str(changeCode(korpop1))

# 변수명 변경
korpop1 <- rename(korpop1,
                  household = 가구_계_가구)

# 그래프로 만들기
ggplot(data = korpop1, aes(x = reorder(name, -household), y = household)) +
  geom_col()



####### 지역별 가구당 평균 구성인원 수
korpop1 <- korpop1 %>% 
  mutate(mean_pop = pop / household)
korpop1

ggplot(data = korpop1, aes(x = reorder(name, -mean_pop), y = mean_pop)) +
  geom_col() +
  ylim(0, 5)



####### 지역별 남녀 성비
korpop1<- rename(korpop1,
                 male = 남자_명,
                 female = 여자_명)

korpop1 <- korpop1 %>% 
  mutate(sex_ratio = male / female * 100)
korpop1

ggplot(data = korpop1, aes(x = reorder(name, -sex_ratio), y = sex_ratio)) +
  geom_col() +
  ylim(0, 150)

ggChoropleth(data = korpop1,
             aes(fill = sex_ratio,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)



####### 지역별 외국인 비율
korpop1 <- rename(korpop1,
                  foreigner = 외국인_계_명)

korpop1$foreigner <- as.numeric(korpop1$foreigner)

korpop1 <- korpop1 %>% 
  mutate(foreigner_ratio = foreigner / pop * 100)
korpop1

ggplot(data = korpop1, aes(x = reorder(name, -foreigner_ratio), y = foreigner_ratio)) +
  geom_col() +
  ylim(0, 0.5)

ggChoropleth(data = korpop1,
             aes(fill = foreigner_ratio,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)


####### 결핵 환자 수
## 지역별 결핵 환자 수
new_tbc <- tbc %>% 
  filter(!is.na(NewPts)) %>% 
  group_by(name) %>% 
  summarise(sum_NewPts = sum(NewPts))

new_tbc

ggplot(data = new_tbc, aes(x = reorder(name, -sum_NewPts), y = sum_NewPts)) +
  geom_col()

## 연도별 결핵 환자 수
new2_tbc <- tbc %>% 
  filter(!is.na(NewPts)) %>% 
  group_by(year) %>% 
  summarise(sum_NewPts = sum(NewPts))

new2_tbc

ggplot(data = new2_tbc, aes(x = year, y = sum_NewPts, group = 1)) +
  geom_line()


####### 조인 사용해보기
korpop1

# 15년도의 지역별 결핵환자만 추출
tbc_code <- tbc %>% 
  filter(!is.na(NewPts) & year == 2015) %>% 
  select(code, NewPts) %>% 
  arrange(code)

tbc_code
tbc_code$code <- as.character(tbc_code$code)
tbc_code

# left_join
korpop1 <- left_join(korpop1, tbc_code, by = 'code')
korpop1

## 지역별 가구당 결핵환자 발생 확률
korpop1 <- korpop1 %>% 
  mutate(household_NewPts = NewPts / household * 100)
korpop1

ggplot(data = korpop1, aes(x = reorder(name, -household_NewPts), y = household_NewPts)) +
  geom_col() +
  ylim(0, 0.5)

## 연도별 서울과 부산의 환자 수 비교
tbc
tbc_sb <- tbc %>% 
  filter(!is.na(NewPts) & name %in% c('서울특별시', '부산광역시')) %>% 
  select(code, name, year, NewPts) %>% 
  arrange(code)
tbc_sb

ggplot(data = tbc_sb, aes(x = year, y = NewPts, fill = name)) +
  geom_col()

ggplot(data = tbc_sb, aes(x = year, y = NewPts, fill = name)) +
  geom_col(position = 'dodge')
