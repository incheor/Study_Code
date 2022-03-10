exam <- read.csv('C:/Souuces/StudyR/Data/csv_exam.csv')
exam
head(exam)
tail(exam)
View(exam)
table(exam)
dim(exam)

mpg <- as.data.frame(ggplot2::mpg)
mpg

install.packages('dplyr')
library(dplyr)

df_raw <- data.frame(var1 = c(1, 2, 1), var2 = c( 2, 3, 2))
df_raw

# 복사본 생성
df_new <- df_raw
df_new

# 컬럼명 변경
df_new <- rename(df_new, v2 = var2)
df_new

# 파생변수 생성
df <- data.frame(var1 = c(1, 2, 1), var2 = c( 2, 3, 2))
df$var_sum <- df$var1 + df$var2
df$var_mean <- (df$var1 + df$var2) / 2
df

# 통합 연비 필드 생성
mpg$total <- (mpg$cty + mpg$hwy) / 2
head(mpg)

# 통합 연비의 히스토그램 생성
hist(mpg$total)


# 20 이상이면 pass, 아니면 fail
mpg$test <- ifelse(mpg$total >= 20, 'pass', 'fail')
head(mpg, 20)
table(mpg$test)

# 빈도 막대그래프
library(ggplot2)
qplot(mpg$test)

# 이중 조건문으로 등급 파생변수 추가하기
mpg$grade <- ifelse(mpg$total >= 30, 'A', ifelse(mpg$total >= 20, 'B', 'C'))
table(mpg$grade)
qplot(mpg$grade)
