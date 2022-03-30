# 몇번쨰 있는지 찾을 분수 입력받기
X = int(input())

# 임시변수
tmp = 0

# 찾는 분수가 몇번째 라인에 있는지 알아보기
for i in range(1, X + 1) :
    # 임시변수에 각 라인의 분수의 개수를 더함
    tmp += i
    # 임시변수가 X보다 커지면 분수는 i번째 줄에 있어서 종료
    if tmp >= X :
        break

print(X)
print(tmp)
print(i)