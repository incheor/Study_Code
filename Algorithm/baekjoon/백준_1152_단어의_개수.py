import sys

# 입력받을 때 공백을 기준으로 나눔
S = sys.stdin.readline().split()
# 개수 세는 용도
c = 0
# for문으로 하나씩 꺼냄
for s in S :
    # 리스트에 값이 있을 떄마다 +1
    c += 1
# print
print(c)