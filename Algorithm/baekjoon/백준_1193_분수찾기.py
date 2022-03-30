X = int(input())

n = 1
count = 1
bunsu = ''

while True :
    tmp_1 = 1
    tmp_2 = n
    
    while True :
        if count == X or tmp_1 == n or tmp_2 == 1 :
            break
        tmp_1 += 1
        tmp_2 -= 1
        count += 1
    if count == X :
        if n % 2 == 0 :
            bunsu = str(tmp_1) + '/' + str(tmp_2)
        else :
            bunsu = str(tmp_2) + '/' + str(tmp_1)
        print(bunsu)
        break
    count += 1
    n += 1