install.packages('cowsay') # cowsay 패키지 설치하기
library(cowsay) # cowsay 패키지 불러오기

byNameList = c('cat', 'smallcat', 'snowman')
for(byName in byNameList){
    say('hello, world!', by = byName)
}