a = int(input())
b = int(input())
c = int(input())

axbxc = a * b * c
axbxc = str(axbxc)

list_count = []

for n in range(0, 10) :
    count = 0
    for i in range(0, len(axbxc)) :
        if str(n) == axbxc[i] :
            count = count + 1
    list_count.append(count)

for i in range(0, 10) :
    print(list_count[i])