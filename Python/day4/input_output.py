# 입출력
# input을 하면 컴퓨터는 입력이 들어올 때까지 기다린다

# number = input('숫자를 입력하세요: ') # 사용자에게 입력하라고 알려주자
# print(type(number)) # 숫자를 입력해도 input은 받을 때 자료형이 string이기 때문에
# number = int(number) # 입력값을 형변환 해주거나
# print(number)

# number = int(input('숫자를 입력하세요: ')) # 처음부터 int타입으로 받도록 하면 된다
# print(type(number))

# Escape Character(이스케이프 문자)
print('원래문장')
print('Life is short. You need Python.')
# \r : 뒤의 문장을 처음부터 다시 적음
print('적용한 문장')
print('Life is short.\r Python.')

# \' : 홑따옴표 안에서 홑따옴표 쓰기
# \b : 글자 하나만큼 앞으로 감(백스페이스)
# \t : 탭 만큼 띄어쓰기