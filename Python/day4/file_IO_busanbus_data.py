# 파일 입출력 활용
# 부산버스 노선별 이용건수
import csv

file_name = '부산버스정보.csv'
f = open(file_name, mode='r', encoding='utf-8')

reader = csv.reader(f, delimiter=',') # 구분자는 ,(콤마)로 설정
next(reader) # 헤더(컬럼명)를 없에줌
for line in reader:
    print(line) # 한 줄 한 줄을 리스트로 출력함

f.close()