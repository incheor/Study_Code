# 텍스트 마이닝
# 대통령 연설문 텍스트 마이닝

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

# 노무현 대통령
# 파일 읽기
txt_NMH <- readLines('C:/Souuces/StudyR/Data/speech_NMH.txt', encoding = 'UTF-8')
txt_NMH

# 특수문자 제거
txt_NMH <- str_replace_all(txt_NMH, "\\W", " ")
txt_NMH

# 단어 추출
nouns_NMH <- extractNoun(txt_NMH)
wordcount_NHM <- table(unlist(nouns_NMH))
wordcount_NHM

# 데이터 프레임으로 형변환
df_word_NMH <- as.data.frame(wordcount_NHM, stringsAsFactors = F)
df_word_NMH

# 변수명 변경
df_word_NMH <- rename(df_word_NMH,
                  word = Var1,
                  freq = Freq)
df_word_NMH

# 두글자 이상 단어 추출
df_word_NMH <- df_word_NMH %>% 
  filter(nchar(word) >= 2)
df_word_NMH

# 상위 100개 추출
top_100_NMH <- df_word_NMH %>% 
  arrange(desc(freq)) %>% 
  head(100)
top_100_NMH

# wordcloud 라이브러리로 시각화
pal <- brewer.pal(8, 'Dark2')
set.seed(1234)
wordcloud(words = top_100_NMH$word,
          freq = top_100_NMH$freq,
          min.freq = 1,
          max.words = 100,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)



# 김대중 대통령
# 파일 읽기
txt_KDJ <- readLines('C:/Souuces/StudyR/Data/speech_KDJ.txt', encoding = 'UTF-8')
txt_KDJ

# 특수문자 제거
txt_KDJ <- str_replace_all(txt_KDJ, "\\W", " ")
txt_KDJ

# 단어 추출
nouns_KDJ <- extractNoun(txt_KDJ)
wordcount_KDJ <- table(unlist(nouns_KDJ))
wordcount_KDJ

# 데이터 프레임으로 형 변환
df_word_KDJ <- as.data.frame(wordcount_KDJ, stringsAsFactors = F)
df_word_KDJ

# 변수명 변경
df_word_KDJ <- rename(df_word_KDJ,
                  word = Var1,
                  freq = Freq)
df_word_KDJ

# 두글자 이상 단어 추출
df_word_KDJ <- df_word_KDJ %>% 
  filter(nchar(word) >= 2)
df_word_KDJ

# 상위 100개 추출
top_100_KDJ <- df_word_KDJ %>% 
  arrange(desc(freq)) %>% 
  head(100)
top_100_KDJ

# wordcloud 라이브러리로 시각화
pal <- brewer.pal(8, 'Dark2')
set.seed(1234)
wordcloud(words = top_100_KDJ$word,
          freq = top_100_KDJ$freq,
          min.freq = 1,
          max.words = 100,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)



# 이명박 대통령
# 파일 읽기
txt_LMB = readLines('C:/Souuces/StudyR/Data/speech_LMB.txt', encoding = 'UTF-8')
txt_LMB

# 특수 문자 제거
txt_LMB <- str_replace_all(txt_LMB, "\\W", " ")
txt_LMB

# 단어 추출
nouns_LMB <- extractNoun(txt_LMB)
wordcount_LMB <- table(unlist(nouns_LMB))
wordcount_LMB

# 데이터 프레임으로 형 변환
df_word_LMB <- as.data.frame(wordcount_LMB, stringsAsFactors = F)
df_word_LMB

# 변수명 변경
df_word_LMB <- rename(df_word_LMB,
                      word = Var1,
                      freq = Freq)
df_word_LMB

# 두글자 이상 단어 추출
df_word_LMB <- df_word_LMB %>% 
  filter(nchar(word) >= 2)
df_word_LMB

# 상위 100개 추출
top_100_LMB <- df_word_LMB %>% 
  arrange(desc(freq)) %>% 
  head(100)
top_100_LMB

# wordcloud 라이브러리로 시각화
pal <- brewer.pal(8, 'Dark2')
set.seed(1234)
wordcloud(words = top_100_LMB$word,
          freq = top_100_LMB$freq,
          min.freq = 1,
          max.words = 100,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)




# 박근혜 대통령
# 파일 읽기
txt_PGH = readLines('C:/Souuces/StudyR/Data/speech_PGH.txt', encoding = 'UTF-8')
txt_PGH

# 특수 문자 제거
txt_PGH <- str_replace_all(txt_PGH, "\\W", " ")
txt_PGH

# 단어 추출
nouns_PGH <- extractNoun(txt_PGH)
wordcount_PGH <- table(unlist(nouns_PGH))
wordcount_PGH

# 데이터 프레임으로 형 변환
df_word_PGH <- as.data.frame(wordcount_PGH, stringsAsFactors = F)


# 변수명 변경
df_word_PGH <- rename(df_word_PGH,
                      word = Var1,
                      freq = Freq)
df_word_PGH

# 두글자 이상 단어 추출
df_word_PGH <- df_word_PGH %>% 
  filter(nchar(word) >= 2)
df_word_PGH

# 상위 100개 추출
top_100_PGH <- df_word_PGH %>% 
  arrange(desc(freq)) %>% 
  head(100)
top_100_PGH

# wordcloud 라이브러리로 시각화
pal <- brewer.pal(8, 'Dark2')
set.seed(1234)
wordcloud(words = top_100_PGH$word,
          freq = top_100_PGH$freq,
          min.freq = 1,
          max.words = 100,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)
