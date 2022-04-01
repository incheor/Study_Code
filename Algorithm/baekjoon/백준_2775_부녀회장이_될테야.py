# 테스트 케이스 입력받기
T = int(input())

for t in range(T) :
    # 층 번호 입력
    k = int(input())
    # 호 번호 입력
    n = int(input())
    
    # 0층 각 호실 거주민(기준) : 1 ~ n
    list_std = list(range(1, n + 1))
    
    while True :
        print(list_std)
        break