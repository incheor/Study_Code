# 몇번째 분수 구할지 입력받음
X = int(input())

# 기준수
n = 1

# 반복문 내부 카운트용
count = 1

# 출력할 분수
bunsu = ''

while True :
    # 기준수를 기준으로 임시변수 만듬
    tmp_1 = 1
    tmp_2 = n
    # 위의 임시변수를 줄이고 늘림
    while True :
        # count가 X와 일치하거나 임시변수가 1이나 기준수가 되면 종료
        if count == X or tmp_1 == n or tmp_2 == 1 :
            break
        # 임시변수 1은 기준수오 늘리고 2는 1로 줄이기
        tmp_1 += 1
        tmp_2 -= 1
        # 카운트용 변수 +1
        count += 1
    # 카운트용 변수가 입력받은 수와 일차하면 반복문 종료
    if count == X :
        # 기준수가 짝수일 경우
        if n % 2 == 0 :
            bunsu = str(tmp_1) + '/' + str(tmp_2)
        # 기준수가 홀수일 경우
        else :
            bunsu = str(tmp_2) + '/' + str(tmp_1)
        print(bunsu)
        break
    # 카운트용 변수 +1
    count += 1
    # 기준수 +1
    n += 1