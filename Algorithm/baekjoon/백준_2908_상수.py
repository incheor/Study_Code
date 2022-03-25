import sys

# map으로 한번에 여러개 입력받기
n1, n2 = map(str, sys.stdin.readline().split())

# 거꾸로 정렬하고 정수로 바꾸기
n1 = int(n1[:: -1])
n2 = int(n2[:: -1])

# 두 수 비교하기
if n1 > n2 :
    print(n1)
else :
    print(n2)