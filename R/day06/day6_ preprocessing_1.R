# 데이터 가공

# 정렬 : arrange

getwd()
setwd('C:/Souuces/StudyR/day06')

install.packages('dplyr')
library(dplyr)
library(readxl)

exam <- read.csv('C:/Souuces/StudyR/Data/csv_exam.csv')

# 정렬은 기본적으로는 오름차순임
exam %>% arrange(math)

# 내림차순 정렬
exam %>% arrange(desc(math))

# 정렬 기준 변수 여러개 지정
# 가장 좌측 변수를 기준으로 먼저 정렬하고 
# 다음은 오른쪽 기준으로 정렬렬
exam %>% arrange(class, math)

# 연습
mpg <- as.data.frame(ggplot2::mpg)
mpg

audi <- mpg %>% filter(manufacturer == 'audi')
head(audi %>% arrange(desc(hwy)))

# 한 줄로 하기, 이것도 됨
mpg %>% filter(manufacturer == 'audi') %>% arrange(desc(hwy)) %>%  head(5)

# 조회용 파생변수 추가하기 : mutate
exam %>% mutate(total = math + english + science) %>% head
exam %>% mutate(total = math + english + science, 
                mean = round((math + english + science) / 3)) %>% head
exam %>% mutate(test = ifelse(science >= 60, 'pass', 'fail')) %>% head
exam # 확인해보면 실제로 추가되되지는 않음

# 연습
new_mpg <- mpg
new_mpg <- new_mpg %>% mutate(total = cty + hwy)
new_mpg <- new_mpg %>% mutate(mean = total / 2)

# 요약하기 : group_by + summarise
exam %>% summarise(mean_math = mean(math))
exam %>% group_by(class) %>% summarise(mean_math = mean(math))
exam %>% group_by(class) %>%  # class별로 그룹핑
  summarise(mean_math =mean(math), # 수학 점수 평균
            sum_math = sum(math), # 수학점수 합계
            median_math = median(math), # 수학 점수 중앙값
            max_math = max(math), # 수학 점수 최댓값값
            n = n()) # 학생 수

# 조건이 두 개 이상인 경우 두 조건이 같은 것 끼리 그룹핑
mpg %>% group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty), n = n()) %>% 
  head(10)

# 연습 1
# 회사별 suv 차량의 평균 연비를 내림차순으로 정렬
suv_mpg <- mpg
suv_mpg %>% filter(class == 'suv') %>% 
  group_by(manufacturer) %>% 
  summarise(mean = mean(cty + hwy)) %>% 
  arrange(desc(mean))

# 연습 2
new_mpg <- mpg

# 회사별 고속도로 연비를 내림차순으로 정렬
new_mpg %>% group_by(manufacturer) %>% 
  summarise(mean = mean(hwy)) %>% 
  arrange(desc(mean))

# 회사별 경차 생산 대수를 내림차순으로 정렬
new_mpg %>% filter(class == 'compact') %>% 
  group_by(manufacturer) %>% 
  summarise(n_compact = n()) %>% 
  arrange(desc(n_compact))

# 데이터 합치기 : left_join, bind_rows
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

total <- left_join(test1, test2, by = 'id')
total

name <- data.frame(class = c(1, 2, 3, 4, 5), teacher = c('kim', 'lee', 'park', 'choi', 'jung'))
exam_new <- left_join(exam, name, by = 'class')
exam_new

group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                    test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(1, 2, 3, 4, 5),
                    test = c(70, 83, 65, 95, 80))
group_all <- bind_rows(group_a, group_b)
group_all

# 연습
fuel <- data.frame(fl = c('c', 'd', 'e', 'p', 'r'),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
mpg_new <- left_join(mpg, fuel, by = 'fl')
mpg_new
mpg_new %>% select(model, fl, price_fl) %>% head(5)
