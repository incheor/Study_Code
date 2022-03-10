list_a = []
list_count = []

for i in range(0, 10) :
    n = int(input())
    n = n % 42
    list_a.append(n)

for i in range(0, 10) : 
    count = 0
    for j in range(i + 1, 10) :
        if list_a[i] == list_a[j] :
            count = count + 1
    if count == 0 :
        list_count.append(list_a[i])

print(len(list_count))