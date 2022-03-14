import sys

input = sys.stdin.readline
S = input()
S = S.upper()
list_count = list()
max = 0

for i in range(0, len(S)) :
    count = 0
    for j in range(i, len(S)) :
        if S[i] == S[j] :
            count = count + 1
    list_count.append(count)
    
for i in range(0, len(list_count)) :
    print('list_count', list_count[i])
    print('befor max', max)
    if max == list_count[i] :
        max = -1
    elif max < list_count[i] :
        max = list_count[i]
    print('after max', max)
        
if max == -1 :
    print('?')
else :
    print(S[max])