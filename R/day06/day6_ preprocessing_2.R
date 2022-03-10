# 데이터 정제

getwd()
setwd('C:/Souuces/StudyR/day06')

install.packages('dplyr')
library(dplyr)

exam <- read.csv('C:/Souuces/StudyR/Data/csv_exam.csv')

mpg <- as.data.frame(ggplot2::mpg)

# 결측치
df <- data.frame(sex = c('M', 'f', NA, 'M','F'),
                 score = c(5, 4, 3, 2, NA))
df

is.na(df) # 결측치 확인
table(is.na(df)) # 결측치 빈도 출력

# 결측치가 하나라도 있으면 계산을 할 수 없음
mean(df$score)

df %>% filter(is.na(score)) # score 중 NA 값이 있는 행만 출력
df_nomiss <- df %>% filter(!is.na(score)) # score 중 NA 값이 없없는 행만 출력
df_nomiss <- df_nomiss %>% filter(!is.na(sex))
df_nomiss

# na.omit(): 결측치가 하나라도 있는 행은 제거
df_nomiss2 <- na.omit(df)
df_nomiss2

# 결측치 제거
mean(df$score, na.rm = T)

# 확인
# math 컬럼의 3, 8, 15 행에 NA값 할당
exam[c(3, 8, 15), 'math'] <- NA

exam %>% summarise(mean_math = mean(math))

exam %>% summarise(mean_math = mean(math, na.rm = T))

# 결측치 대체하기 : 일반적으로 결측치를 평균값으로 대체함
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
exam$math

# 연습
mpg <- as.data.frame(ggplot2::mpg)                 
mpg [c(65, 124, 131, 153, 212), 'hwy'] <- NA

table(is.na(mpg$hwy)) # 결측치 빈도 출력
table(is.na(mpg$drv)) # 결측치 빈도 출력

mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>%  
  summarise(mean_hwy = mean(hwy, na.rm = T))


# 이상치
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1), # 여기서 이상치는 3
                      score = c(5, 4, 3, 4, 2, 6)) # 5 이상이 이상치
table(outlier$sex)
table(outlier$score)

# 이상치를 NA값으로 바꾸기
# 3이 이상치
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
# 5 이상이 이상치
outlier$score <- ifelse(outlier$score > 5 , NA, outlier$score)
outlier$sex
outlier$score

# 이제 NA값 제거
outlier %>% filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

# 이상치
mpg <- as.data.frame(ggplot2::mpg) 
boxplot(mpg$hwy)$stats

# 이상치 정의 및 결측치로 대체
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치 제외하고 분석
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

# 연습
mpg <- as.data.frame(ggplot2::mpg)

# 일부러  이상치 만들기
mpg[c(10, 14, 58, 93), 'drv'] <- 'k'
mpg[c(29,43, 129, 204), 'cty'] <- c(3, 4, 39, 42)

# drv 변수의 이상치를 결측치로 대체
table(mpg$drv)
table(is.na(mpg$drv))
mpg$drv <- ifelse(mpg$drv %in% c('4', 'f', 'r'), mpg$drv, NA)
table(is.na(mpg$drv))

# cty 변수의 이상치를 결측치로 대체
boxplot(mpg$cty)$stats
table(mpg$cty)
mpg$cty <- ifelse(mpg$cty <= 9 | mpg$cty >= 26, NA, mpg$cty)
boxplot(mpg$cty)
table(mpg$cty)

# 결측치를 제외한 drv 변수별
# 결측치를 제외한 cty 값의 평균 구하기
mpg %>% 
  filter(!is.na(drv)) %>% 
  group_by(drv) %>% 
  summarise(cty = mean(cty, na.rm = T))

