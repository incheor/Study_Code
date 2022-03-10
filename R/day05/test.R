# 데이터 프레임 만들어보기
# 영어 정수 변수 생성
english <- c(90, 80, 60, 70)
english

# 수학 점수 변수 생성
math <- c(50, 60, 100, 20)
math

# 반 변수 생성
class <- c(1, 1, 2, 2)
class

# 변수들을 합쳐서 데이터 프레임으로 만들기
df_midterm <- data.frame(english, math, class)
df_midterm

# 위의 데이터 프레임을 csv 파일로 저장하기
write.csv(df_midterm, file = './df_midterm.csv')

# 영어 변수의 평균 산출
mean(df_midterm$english)
# 또는
mean(df_midterm[[1]])
# 또는
mean(df_midterm[,1])

# R에서 엑셀, csv 파일 등을 읽어올 수 있게 해주는 라이브러리
install.packages('readxl')
library(readxl)

df_exam <- read_excel('./data/excel_exam.xlsx')
df_exam # 출력

# col_names : 컬럼명(변수, 필드)가 없을 경우
df_exam_novar <- read_excel('./data/excel_exam_novar.xlsx', col_names = F)
df_exam_novar

# sheet : 엑셀 파일의 3번째 시트의 데이터 읽기
df_exam_sheet <- read_excel('./data/excel_exam_sheet.xlsx', sheet = 3)
df_exam_sheet

# csv 파일 읽기
exam_csv <- read.csv('./data/csv_exam.csv')
exam_csv
