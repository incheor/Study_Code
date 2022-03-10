# 리스트
# 리스트 인덱싱
cafe = list(espresoo = c(4, 5, 3, 6, 5, 4, 7), 
americano = c(63, 68, 64, 68, 72, 89, 94), 
latte = c(61, 70, 59, 71, 71, 92, 88), 
price = c(2.9, 2.5, 3.0), 
menu = c('espresso', 'americano', 'latte'))

cafe
str(cafe)
summary(cafe)
cafe[[5]]
cafe$menu
cafe$menu = factor(cafe$menu)
str(cafe)

cafe$price
names(cafe$price)
names(cafe$price) = cafe$menu
cafe$price
names(cafe$price)
str(cafe)
str(cafe$price)
cafe$price[1]

# 자동차 연비와 관련된 mtcars, 이건 read가 없는 내장자료
mtcars

str(mtcars) # 해당 자료의 구조 좀 보자, 데이터 프레임이네
head(mtcars, 3) # 위에서부터 3개 레코드만 보자
summary(mtcars) # 중앙값과 평균값 등
plot(mtcars$cyl) # 자료구조의 필드(cyl)를 하나 선택하고 그것을 기준으로 각 레코드들의 값을 산점도로 보기

summary(mtcars$cyl) # cyl 필드의 데이터 기술 보기
factor(mtcars$cyl) # 팩터로 출력
summary(factor(mtcars$cyl)) # cyl의 레코드들을 중복은 제거하고 종류(첫번째줄)와 빈도수,갯수(두번째줄)를 함께 보여줌
# 아래 3줄의 코드는 필드명을 본다, 결과는 같음
names(summary(factor(mtcars$cyl)))
levels(factor(mtcars$cyl))
unique(mtcars$cyl)

tmp = summary(factor(mtcars$cyl))
tmp
names(tmp) = c('cyl:4', 'cyl:6', 'cyl:8') # 필드명을 지정할 수 있음
tmp # 위의 tmp 출력과 비교해보기
str(tmp)
tmp[1] # 1번 인덱스인 'cyl:4'리스트를 보자

# split(자료, 기준) : 이거하면 리스트화 됨
tmp = split(mtcars, mtcars$cyl)
tmp # 리스트화
str(tmp)
tmp[[1]] # cyl:4 의 테이터 프레임
split(tmp[[1]], tmp[[1]]$am) # 필드명말고 split(tmp[[1]], tmp[[1]][9]) 이렇게 인덱스 번호로 해도 됨

# 실습
# 1. 부산광역시_현대미술관 관람객 수.csv 다운
# 2. csv 파일 읽기 : 변수 = read.csv('경로')
# 3. 구조 파악 : str(변수) --> 타입, 행과 열의 갯수
# 4. 데이터 샘플 확인 : head(변수, 볼 행의 수)
# 5. 데이터 기본 기술 통계 : summary(변수)
# 6. NA값 반드시 확인 : summary(변수), is.na(변수) 등
# 7. NA값을 처리 : 보통 0이고 중앙값이나 평균값으로 대체, 아니면 임의값으로 대체
# 8. 자료가 정확한지 확인 : 예시의 자료에서는 월의 갯수가 정확한지

dir() # 파이썬의 os.listdir / glod 처럼 폴더 내 자료 리스트
data_file = read.csv("부산광역시_현대미술관 관람객 수_20201231.csv")
# 읽어와서 변수에 저장
# 이렇게 읽어오면 다른 설정을 안 했으면 가장 상단은 필드, 문자는 factor로 읽음
str(data_file) # 이 파일의 구조 : 이 파일은 데이터 프레임
head(data_file, 12) # 자료의 앞부분만 출력
summary(data_file) # 이 자료 기술 : 각 필드별 최대, 최소, 중앙값, NA값의 갯수 등
factor(summary(data_file))
names(data_file) # 파일의 가장 위에 있는 데이터를 필드명으로 보고 필드명만 가져옴
data_file$연도 # str(data_file)로 필드명 확인하고 해당 필드(연도)만 출력
data_file[,1] # 이것도 연도만 출력
max(data_file$연도) # 연도 필드 중 최대값 출력

# 인덱싱 연습
# 연도와 관람객 수만 출력
data_file[,c(1, 3)]

# 위 12개 자료만 출력(2018년도 자료만 출력)
data_file[1:12,]

# 아래 12개 자료만 출력(2020년도 자료만 출력)
data_file[25:36,]

# 2018년도 월과 관람객 수만 출력
data_file[1:12, 2:3]

# NA값 처리
data_file[is.na(data_file)] = 0 # NA(결측치) 값을 0으로
summary(is.na(data_file)) # NA 갯수를 TRUE로 알려줌, NA가 많으면 해당 자료를 사용해도 될까 고민해야 함
par(mfrow = c(3, 1)) # 차트 분할, 차트창을 닫을 때까지 유지됨
index = 1
barplot(table(is.na(data_file[index])) , main = names(data_file[index]))
index = 2
barplot(table(is.na(data_file[index])) , main = names(data_file[index]))
index = 3
barplot(table(is.na(data_file[index])) , main = names(data_file[index]))

# 1월 ~ 12월까지 자료가 3개씩 나오는지
table(data_file[[1]]) # 테이블로 출력

year = split(data_file, data_file$연도) # 연도를 기준으로 나눠서 변수에 저장
str(year) # 데이터프레임을 split()하니까 리스트로 출력됨
year[[1]] # 리스트의 1번층을 확인해보면 2018의 데이터프레임이 나옴
str(year[[1]]) # 확인

par(mfrow = c(3,1)) # 이건 차트를 그릴 때 한 화면에 여러개 그려줌

index = 1
yearData  = year[[index]]
yearData[[index]]
title = year[[index]][1,1]
title
plot(yearData$월, yearData$관람객수, main=title)

index = 2
yearData = year[[index]]
title = year[[index]][1,1]
plot(yearData$월, yearData$관람객수, main=title)

index = 3
yearData = year[[index]]
title = year[[index]][1,1]
plot(yearData$월, yearData$관람객수, main=title)