def d(n) :
    sum = n
    n = str(n)
    for i in range(0, len(n)) :
        sum = sum + int(n[i])
    return sum

print(d(100))