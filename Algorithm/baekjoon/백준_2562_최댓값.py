list_a = list()
max = 0
max_i = 0

for i in range(0, 9) :
    n = int(input())
    list_a.append(n)

for i in range(0, 9) :
    if max < list_a[i] :
        max = list_a[i]
        max_i = i + 1

print(max)
print(max_i)