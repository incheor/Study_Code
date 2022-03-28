n = int(input())

# 방 이동 카운트용
count = 1

while True :
    if n == 1 :
        break
    n = n - (count * 6)
    if n <= 0 :
        n = 1
    count += 1

print(count)