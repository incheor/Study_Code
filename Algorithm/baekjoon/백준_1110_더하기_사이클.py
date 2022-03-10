n = int(input())
tmp = n
i = 0
while True :
    i = i + 1
    tmp = (tmp % 10) * 10 + (((tmp // 10) + (tmp % 10)) % 10)
    if n == tmp :
        print(i)
        break