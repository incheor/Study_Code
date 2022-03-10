# 연산자
# 연산자에는 우선순위가 있으니까 조심
# 사칙연산
a = 11
b = 4
print(a + b)
print(a - b)
print(a * b)
print(a ** b)
print(a / b)
print(a // b)
print(a % b)

# 문자열 연산
str1 = 'Hello'
str2 = 'World!'
res = str1, str2 # , 연산은 튜플로 만듬
print(res)
res = str1 + str2 # + 연산은 문자열을 합친다(오라클의 concat, || 같은거)
print(res)
print(str1 * 10) # 문자열 연산에서는 곱하기 연산 가능(문자열 * 문자열은 불가능)
# 문자열 연산에서는 뺄셈, 나눗셈, 나머지, 제곱 연산은 없다

# 문자열 길이: len()
print(len(str1), len(str2))
str3 = '안녕하세요'
print(len(str3))

# 문자열 인덱스, 리스트와 동일한 작업
print(str3[0])
print(str3[1])
print(str3[2])
print(str3[3])
print(str3[4])
# print(str3[5]) 예외 발생

print(str3[-1]) # 인덱스 번호에 -(마이너스) 붙이면 뒤에서부터 거꾸로 출력
print(str3[-2])
print(str3[-3])
print(str3[-4])
print(str3[-5])

# 문자열 자르기
date = '2022-01-17 14:39:25'
print(date)
year = date[:4] # 시작할 때는 생략 가능
print('year:', year)
month = date[5:7]
print('month:', month)
day = date[8:10]
print('day:', day)
hour = date[11:13]
print('hour:', hour)
minute = date[14:16]
print('minute:', minute)
second = date[17:] # 마지막도 생략 가능
print('second:', second)

list_a = [1, 2, 3, 4, 5] # 숫자는 변환 가능
list_a[1] = 19
print(list_a)

# str3[1] = '저리가' # 문자열은 변환 불가능
# print(str3)

str4 = '저리가' + str3[3:] # 새로 변수 만들어서 해야 함
print(str4)

# 포맷팅: 문자열.format() 아니면 문자열 맨 앞에 f
첫번째_단어 = '투'
두번째_단어 = '유'
str1 = "I'm so happy {0} U. are {1}".format(첫번째_단어, 두번째_단어)
print(str1)

str2 =  f"I'm so happy {첫번째_단어} U. are {두번째_단어}" # 둘 다 가능
print(str2)

# 소숫점 아래 포맷팅
import math
myPi = math.pi
print('{0}'.format(myPi))
print('{0:0.2f}'.format(myPi)) 
print(f'{myPi:0.2f}') # 문자열 뿐만 아니라 숫자도 둘 다 가능

# 활용
full_name = '홍 길동'
age = 20
greeting = f'''안녕하세요. 저는 {full_name}입니다.
나이는 {age:0.1f}이구요.'''
print(greeting)

# 숫자 1000단위 콤마 넣기
money = 1000000000000000
print(format(money, ',d'))

# 현재 시간 생성 및 포맷팅
from datetime import datetime
now = datetime.now()
print(now.strftime('%Y년 %m월 %d일 %H:%M:%S')) # 대소문자 구분 잘 하자

# split()
part_name = full_name.split() # split() 쓰면 기본적으로는 공백을 기준으로 분리시키고 리스트로 만들어줌
print(type(part_name))
print(part_name)

# split() 활용 예시
test = ' Hey , guys'
print(test.split(','))

code = 'TEST|2022|01|17|F45678'
split_code = code.split('|')
print(split_code)

# replace(): 단어 교체
print(full_name.replace('홍', '김'))

# strip(): 공백 제거 == 오라클의 trim
aaa ='   Hello, World!   '
print(aaa.strip())
print(aaa.rstrip()) # 오른쪽 공백만 제거
print(aaa.lstrip()) # 왼쪽 공백만 제거

# 기타 함수
# index를 활용해 해당 문자의 위치 찾기
print(full_name.index('홍'))
print(full_name.index('길'))

# find를 활용해 해당 문자의 위치 찾기
print(full_name.find('길'))
print(full_name.find('road')) # 없으면 -1을 반환한다

# 해당 문자가 문자열에서 몇 번 나오는지 알고 싶다
print(full_name.count('길'))

# 문자 삽입
print('-'.join(full_name)) # 공백도 문자로 인식함

# 대소문자 변환
name = 'name is king'
print(name.upper()) # 대문자로 만듬(lower()로소문자로 만드는 것도 가능)