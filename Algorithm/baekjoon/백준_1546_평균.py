import sys

n = int(sys.stdin.readline())
m = 0
sum = 0
avg = 0

list_a = list(range(n))
list_a = list(map(int, sys.stdin.readline().split()))

for i in range(0, len(list_a)) :
    if list_a[i] > m :
        m = list_a[i]

for i in range(0, len(list_a)) :
    list_a[i] = list_a[i] / m * 100

for i in range(0, len(list_a)) :
    sum = sum + list_a[i]

avg = sum / len(list_a)
print(avg)
