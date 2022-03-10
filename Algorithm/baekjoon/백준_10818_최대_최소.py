import sys

n = int(input())

list_a = list(map(int, sys.stdin.readline().split()))

max = list_a[0]
min = list_a[0]

for i in range(n) :
    if max < list_a[i] : 
        max = list_a[i]
    if min > list_a[i] : 
        min = list_a[i]

print('{} {}'.format(min, max))