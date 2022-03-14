import sys

input = sys.stdin.readline
T = int(input())
P = list()

for i in range(0, T) :
    temp = ''
    R, S = map(str, input().split())
    for j in range(0, len(S)) :
        temp = temp + S[j] * int(R)
    P.append(temp)

for i in range(0, len(P)) :
    print(P[i])