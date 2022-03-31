# 달팽이가 올라가는 미터, 내려오는 미터, 올라갈 높이
A, B, V = map(int, input().split())

# 며칠 걸림?
day = 1

# 올라간 높이
hsight = 0

# 낮에는 A미터 올라가고 밤에는 B미터 내려옴
while True :
    hsight += A
    if hsight >= V :
        print(day)
        break
    hsight -= B  
    day += 1