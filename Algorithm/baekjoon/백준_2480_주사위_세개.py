dice = list(range(3))
dice[0], dice[1], dice[2] = map(int, input().split())

if dice[0] == dice[1] and dice[1] == dice[2] :
    result = 10000 + dice[0] * 1000
elif dice[0] == dice[1] :
    result = 1000 + dice[0] * 100
elif dice[0] == dice[2] :
    result = 1000 + dice[0] * 100
elif dice[1] == dice[2] :
    result = 1000 + dice[1] * 100
else :
    max = dice[0]
    for i in dice :
        if max < i :
            max = i 
    result = max * 100
print(result)