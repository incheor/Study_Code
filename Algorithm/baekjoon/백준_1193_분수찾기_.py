# 몇번쨰 있는지 찾을 분수 입력받기
X = int(input())

# 임시변수
tmp = 0

# 그 라인에서 몇번째에 있는지
n = 0

# 찾는 분수가 몇번째 라인에 있는지 알아보기
for i in range(1, X + 1) :
    # 임시변수에 각 라인의 분수의 개수를 더함
    tmp += i
    # 임시변수가 X보다 커지면 분수는 i번째 줄에 있어서 종료
    if tmp >= X :
        n = X - (tmp - i)
        break
# i : 몇번쨰 라인인지
# n : 그 라인에서 몇번째에 있는지
# 처음부터 바로 늘리고 줄여서 0, n + 1로 설정해줌
a = 0
b = i + 1
# 늘리고 줄여나가기
for j in range(n) :
    a += 1
    b -= 1

# 짝수 라인은 분자를 늘려가고 홀수 라인은 분모를 늘려감
if i % 2 == 0 :
    print(str(a) + '/' + str(b))
else :
    print(str(b) + '/' + str(a))
    
###################
# 다른 사람이 한 거
###################
a = int(input())

num = 1

while a > num:
    a -= num
    num += 1
    
if(num % 2 == 0):
    print(str(a) + "/" + str(num - a + 1))
else :
    print(str(num - a + 1) + "/" + str(a))