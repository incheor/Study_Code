# random 함수
import random

print(random.choice(range(1, 7))) # 주사위

# 랜덤 숫자 출력
numbers = list(range(1, 46))
lottery = [] # list[]
for i in range(6):
    lottery.append(random.choice(numbers))

print(lottery)
# random 함수는 중복을 막을 수는 없기 때문에 추가적인 작업이 필요하다