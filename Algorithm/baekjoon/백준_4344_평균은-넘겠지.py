import sys

input = sys.stdin.readline
c = int(input())
list_score = list()
list_avg = list()
list_rate = list()

for i in range(0, c) :
    score = list(map(int, input().split()))
    list_score.append(score)

for i in range(0, len(list_score)) :
    sum = 0
    avg = 0
    for j in range(1, len(list_score[i])) :
        sum = sum + list_score[i][j]
    avg = sum / list_score[i][0]
    list_avg.append(avg)

for i in range(0, len(list_avg)) :
    list_up = list()
    count = 0
    for j in range(1, len(list_score[i])) :
        if list_score[i][j] > list_avg[i] :
            list_up.append(list_score[i][j])
    for j in range(0, len(list_up)) :
        count = count + 1
    list_rate.append(round(count/ list_score[i][0] * 100, 3))

for i in range(0, len(list_rate)) :
    print('{:.3f}%'.format(list_rate[i]))