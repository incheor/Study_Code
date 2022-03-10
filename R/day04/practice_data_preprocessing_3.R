# 지지도 보기
setwd('C:/Souuces/StudyR/day4/') # 작업 경로를 설정
dir() # 작업 경로에 필요한 파일이 있는지 확인

install.packages('arules')
library(arules)

tran = read.transactions('trade.txt', format = 'basket', sep =',')
str(tran)
head(tran)
class(tran)

tran
tran@itemInfo
tran@data
tran@data@i
inspect(tran)

rule = apriori(tran, parameter = list(supp = 0.3, conf = 0.1))
str(rule)
inspect(rule) # lift 값이 1이상이면 시너지가 좋다

# 데이터 시각화하기
install.packages('arulesViz')
library(arulesViz)