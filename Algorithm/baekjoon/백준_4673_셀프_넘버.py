# 자기자신과 각 자리수를 더하는 함수을 만드는 방법 1 : 문자열로 변환
# def d(n) :
#     sum = n
#     n = str(n)
#     for i in range(0, len(n)) :
#         sum = sum + int(n[i])
#     return sum

# 자기자신과 각 자리수를 더하는 함수을 만드는 방법 2 : 나머지와 몫을 활용
def d(n) :
    sum = n
    while True :
        if n == 0 :
            break
        sum = sum + n % 10
        n = n // 10
    
    return sum

# 셀프넘버를 판별할 리스트
# 1이면 셀프넘버이고, 0이면 아님
list_self_num = list()

# 위의 리스트에 1을 넣음
for i in range(0, 10000) :
    list_self_num.append(1)

# for문으로 1부터 10000까지 반복하면서 d(n) 함수 실행하기
# d(n) 함수로 만들어지는 수는 셀프넘버가 아니기 때문에
# 위에서 만든 리스트의 값을 0으로 바꾸기
for i in range(1, 10001) :
    n = d(i)
    if n > 10000 : # 1부터 10000까지라서 10000을 초과하면 스킵
        continue
    list_self_num[n -1] = 0

# for문으로 리스트의 값이 1이면 셀프넘버이므로
# 해당 인덱스 번호에 1을 더해서 출력함  
for i in range(0, 10000) :
    if list_self_num[i] == 1 :
        print(i + 1)