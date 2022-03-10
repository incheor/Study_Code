import sys

input = sys.stdin.readline
n = int(input())
list_n = list()
list_score = list()

for i in range(0, n, 1) :
    ox = input()
    list_n.append(ox)

for i in range(0, n, 1) :
    score = 0
    sum = 0
    for j in range(0, len(list_n[i]), 1) :
        if list_n[i][j] == 'O' :
            score = score + 1
            sum = sum + score
        else :
            score = 0
    list_score.append(sum)

for i in range(0, len(list_score)) :
    print(list_score[i])