def solve(a) :
    sum = 0
    for i in range(0, len(a)) :
        sum = sum + a[i]
    
    return sum

a = [10, 11, 12]
n = solve(a)
print(n)