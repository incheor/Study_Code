# 텍스트 마이닝
### KoNLP 라이브러리 사용을 위한 준비

getwd()
setwd('C:/Souuces/StudyR/day07')

install.packages('usethis')
usethis::edit_r_environ()
# 무슨 창이 열리면 아래 코드 입력(주의!) 하고 실행하고 창 닫기
# PATH="${RTOOLS40_HOME}/usr/bin;${PATH}"
Sys.which('make')

# KoNLP 라이브러리를 설치
install.packages("rJava")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

# 테스트
library(KoNLP)
text <- "R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이자 프리웨어이다.[2] 뉴질랜드 오클랜드 대학의 로버트 젠틀맨(Robert Gentleman)과 로스 이하카(Ross Ihaka)에 의해 시작되어 현재는 R 코어 팀이 개발하고 있다. R는 GPL 하에 배포되는 S 프로그래밍 언어의 구현으로 GNU S라고도 한다. R는 통계 소프트웨어 개발과 자료 분석에 널리 사용되고 있으며, 패키지 개발이 용이해 통계 소프트웨어 개발에 많이 쓰이고 있다."
extractNoun(text)

# 만약 환경변수 설정이 안 되면 아래 코드 실행
# R에서 임시로 환경변수 설정해주는 코드드
# Sys.setenv(JAVE_HOME = 'C:\Program Files\Java\jre1.8.0_321')

# 활용
library(dplyr)
useNIADic()

txt <- readLines('C:/Souuces/StudyR/Data/hiphop.txt', encoding = 'UTF-8')
head(txt)