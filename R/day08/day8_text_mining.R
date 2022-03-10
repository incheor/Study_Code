# 텍스트 마이닝

getwd()
setwd('C:/Souuces/StudyR/day08')

library(KoNLP)
library(dplyr)

install.packages('stringr')
library(stringr)

install.packages('wordcloud')
library(wordcloud)

library(RColorBrewer)
library(ggplot2)

useNIADic()

# 파일 읽기
txt <- readLines('C:/Souuces/StudyR/Data/hiphop.txt', encoding = 'UTF-8')
head(txt)

# 특수문자 제거
# stringr 라이브러리 사용
# \\W :  정규표현식, 대문자임, 글자(한글, 영어, 숫자 전부) 제외한 전부를 공백 처리
txt <- str_replace_all(txt, "\\W", " ")
head(txt)

# 단어 추출
nouns <- extractNoun(txt)
# unlist : nouns는 리스트 형태임. table쓰려면 크기를 가진 벡터여야 함. unlist하면 형변환 됨.
wordcount <- table(unlist(nouns))
head(wordcount)

# 데이터 프레임으로 형변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 변경
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 두글자 이상 단어 추출
# nchar : 글자의 갯수
df_word <- filter(df_word, nchar(word) >= 2)
# 아래랑 같은거
df_word <- df_word %>% 
  filter(nchar(word) >= 2)

# 상위 20개 추출
top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

top_20

# wordcloud 라이브러리 사용해서 시각화
# RColorBrewer 라이브러리로 색 조절
pal <- brewer.pal(8, 'Dark2') # Dark2 색상 목록에서 8개 색상만 사용

set.seed(1234) # 난수 설정
wordcloud(words = df_word$word, # 단어
          freq = df_word$freq, # 빈도
          min.freq = 2, # 최소 표현 단어
          max.words = 200, # 최대 표현 단어
          random.order = F, # 고빈도 단어 중앙 배치
          rot.per = .1, # 회전 단어 비율
          scale = c(1.5, 0.3), # 단어 크기 범위
          colors = pal) # 색깔 목록

# wordcloud 단어 색상 변경해보기
pal <- brewer.pal(9, 'Blues')[5:9]

set.seed(1234)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(1.5, 0.3),
          colors = pal)



# 연습
# 국정원 트위터 텍스트 마이닝 : 3744개 트윗
# 파일 읽기
twitter <- read.csv('C:/Souuces/StudyR/Data/twitter.csv',
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = 'UTF-8')

# 변수명 변경
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)
head(twitter)

# 특수문자 제거
# 한글 깨질 수도 있어서 '특수문자 제거' 파트는 스킵하고 진행
twitter$tw <- str_replace_all(twitter$tw, '\\W', " ")

# 단어 추출
# 이거 엄청 오래 걸림
nouns <- extractNoun(twitter$tw)
# 밑에 있는거 오래걸리고 비행기 이륙소리 나니까 하지말자
nouns

# 추출한 단어 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
# 밑에 있는거 오래걸리고 비행기 이륙소리 나니까 하지말자
wordcount


# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
head(df_word)

# 변수명 변경
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
head(df_word)

# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)
head(df_word)

# 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20

# 빈도 순서 변수 생성
order <- arrange(top20, freq)$word
order

# 빈도 순서대로 막대그래프 생성
ggplot(data = top20, aes(x = word, y = freq)) +  
  ylim(0, 2500) +
  geom_col() + 
  coord_flip() +
  scale_x_discrete(limit = order) + # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3) # 빈도 표시

# wordcloud 라이브러리 사용해서 시각화
pal <- brewer.pal(8,"Dark2")
set.seed(1234)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(1.5, 0.3),
          colors = pal)



# 연습
# 대통령 연설문
