import sys

n, x = map(int, sys.stdin.readline().split())
list_a = list(range(n))
list_a = list(map(int, sys.stdin.readline().split()))

temp = ''

for i in list_a :
    if x > i :
        temp = temp + str(i) + ' '

print(temp)