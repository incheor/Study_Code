## 데이터 분석 미니 프로젝트 연습
# practice_DA_mini_protect

getwd()
setwd('C:/Souuces/StudyR/day07')

# 사용할 라이브러리
library(foreign)
library(ggplot2)
library(dplyr)
library(readxl)

# 한국인복지패널데이터 활용
# 'Compression bias (0) is not the usual value of 100' 이런 오류 발생해도 무시하자
raw_welfare <- read.spss(file = 'C:/Users/admin/Desktop/tmp/Koweps_hpc10_2015_beta1.sav', 
                         to.data.frame = T, stringAsFactors = F)
# 복사본 만들기
welfare <- raw_welfare

# 데이터 검토하기
head(welfare)
tail(welfare)
dim(welfare)
str(welfare)
summary(welfare)

# 대규모 데이터는 변수가 많아서 변수명이 코드임
# 이해하고 사용하기 쉽게 변수명 바꾸자
welfare <- rename(welfare,
                  sex = h10_g3, # 성별
                  birth = h10_g4, # 생년월일
                  marriage = h10_g10, # 혼인
                  religion = h10_g11, # 종교
                  income = p1002_8aq1, # 수입
                  code_job = h10_eco9, # 직업 코드
                  code_region = h10_reg7) # 지역 코드


# 데이터 분석 절차 : 아래 절차의 반복
## 1단계 - 변수 검토 및 전처리
## 2단계 - 변수 간 관계 분석

## 성별에 따른 수입 차이 분석
### 1단계 - 변수 검토 및 전처리
#### 변수 검토하기 : 성별
class(welfare$sex)
table(welfare$sex)

#### 전처리
##### 이상치 확인
table(welfare$sex) # 1(남), 2(여) 제외한 다른 값은 없어서 성별에는 이상치 없음
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex) # 만약 9라는 값의 이상치가 있다면 NA로 변경

##### 결측치 확인
table(is.na(welfare$sex)) # 성별변수에는 결측치가 없어서 FALSE만 있음

##### 변수의 값 변경
welfare$sex <- ifelse(welfare$sex == 1, 'male', 'female')
table(welfare$sex)

##### 그래프로 나타내기
qplot(welfare$sex)

#### 변수 검토하기 : 수입
class(welfare$income)
summary(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

#### 전처리
##### 이상치 확인
summary(welfare$income)

##### 이상치 결측 처리
welfare$income<- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income) # 수입이 0, 9999 인 것은 NA로 변경

##### 결측치 확인
table(is.na(welfare$income))

### 2단계 - 변수 간 관계 분석
#### 수입에서 NA는 제외한  성별 수입평균표(NA값 제거X)
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))

sex_income # 확인

#### 그래프 만들기
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()


## 나이와 월급의 관계
### 1단계 - 변수 검토 및 전처리
#### 1. 변수 검토
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

#### 2. 전처리
##### 이상치 확인
summary(welfare$birth)
table(is.na(welfare$birth))

##### 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)

##### 확인
table(welfare$birth)

#### 3. 파생변수 만들기 - 나이
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)

### 2단계 - 변수 간 관계 분석
#### 나에에 따른 월급 평균표
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

head(age_income) # 확인

### 그래프
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()


##연령대와 수입 관계
### 1단계 - 변수 검토 및 전처리
#### 파생변수 만들기 - 청년, 중징년, 노년
welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, 'young',
                       ifelse(age<= 59, 'middle', 'old')))

table(welfare$ageg) # 확인
qplot(welfare$ageg)

### 2단계 - 변수 간 관계 분석
#### 연령대별 월급 평균표 만들기
ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))

ageg_income

### 그래프
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + 
  geom_col() +
  scale_x_discrete(limits = c('young', 'middle', 'old')) # scale_x_discrete(limits = c())하면 리스트에 넣은 순서대로 출력


## 성별 수입 차이는 연령대별로 다를까
## 이번에는 변수가 3개(성별, 수입, 연령대)
### 연령대 및 성별, 수입
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

sex_income

### 연령대 및 성별 수입 그래프
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = 'dodge') + # (position = 'dodge')하면 위, 아래로 나오던걸 분리시켜줌
  scale_x_discrete(limits = c('young', 'middle', 'old'))

### 나이 및 성별 수입
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

### 나이 및 성별 수입 그래프
### 나애대는 연속적이기 때문에 선 그래프 사용
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()


## 직업별 수입 차이
class(welfare$code_job)

### 직종 코드표 읽어오기
list_job <- read_excel('C:/Souuces/StudyR/Data/Koweps_Codebook.xlsx', col_name = T, sheet = 2)
head(list_job)

### left_join 하기
welfare <- left_join(welfare, list_job, id = 'code_job')
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

### 직업과 수입을 필터링하고 수입의 평균값 분석
job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))

### 수입 상위 10개 직업
top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)

top10

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()

### 수입 하위 10개 직업
bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)

bottom10

ggplot(data = bottom10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()


## 성별 직업 빈도
### 남성의 직업 빈도 상위 10개 추출
job_male <- welfare %>% 
  filter(!is.na(job) & sex == 'male') %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_male

ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

### 여성의 직업 빈도 상위 10개 추출
job_female <- welfare %>% 
  filter(!is.na(job) & sex == 'female') %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)

job_female

ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()


## 종교와 이혼율 분석
### 종교 변수 검토
class(welfare$religion)
table(welfare$religion)

### 전처리
welfare$religion <- ifelse(welfare$religion == 1, 'yes', 'no')
table(welfare$religion)
qplot(welfare$religion)


### 혼인 변수 검토
class(welfare$marriage)
table(welfare$marriage)

### 전처리
### 1은 결혼, 3은 이혼
welfare$group_marriage <- ifelse(welfare$marriage == 1, 'marriage', 
                                 ifelse(welfare$marriage == 3, 'divorce', NA))
 
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

### 종교 유무에 따른 이혼율
religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n / tot_group * 100, 1))

religion_marriage

### 이혼 추출
divorce <- religion_marriage %>% 
  filter(group_marriage == 'divorce') %>% 
  select(religion, pct)

divorce
ggplot(data = divorce, aes(x = religion, y= pct)) + geom_col()


## 연령대 및 종교 유무에 따른 이혼율
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n / tot_group * 100, 1))

ageg_marriage

ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg != 'young') %>% 
  group_by(ageg, religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n / tot_group * 100, 1))

df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == 'divorce') %>% 
  select(ageg, religion, pct)

ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col(position = 'dodge')


## 지역별 연령대
class(welfare$code_region)
table(welfare$code_region)

list_region <- data.frame(code_region = c(1:7),
                          region = c('서울', 
                                     '수도권(인천/경기)', 
                                     '부산/경남/울산', 
                                     '대구/경북', 
                                     '대전/충남', 
                                     '강원/충북', 
                                     '광주/전남/전북/제주도'))
welfare <- left_join(welfare, list_region, id = 'code_region')

welfare %>% 
  select(code_region, region) %>% 
  head

region_ageg <- welfare %>% 
  group_by(region, ageg) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n / tot_group * 100, 2))

head(region_ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()

list_order_old <- region_ageg %>% 
  filter(ageg == 'old') %>% 
  arrange(pct)

list_order_old

class(region_ageg$ageg)
levels(region_ageg$ageg)
region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c('old', 'middle', 'young'))
class(region_ageg$ageg)
levels(region_ageg$ageg)

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)
