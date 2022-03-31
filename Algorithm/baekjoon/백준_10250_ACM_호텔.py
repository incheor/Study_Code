import sys
import math
input = sys.stdin.readline

# 몇번 반복할 지 입력받음
T = int(input())

# h, w, n을 담을 리스트
hwn_list = list()

# h, w, n을 담음
for i in range(T) :
    tmp = list(map(int, input().split()))
    hwn_list.append(tmp)

for hwn in hwn_list :
    # room_number의 처음 숫자를 먼저 올리고
    # 그 숫자가 h가 되면 1로 리셋됨
    h = hwn[0]
    w = hwn[1]
    n = hwn[2]
    
    # 호실 뒷쪽 번호(호실 라인)
    xx = math.ceil(n / h)
    if xx < 10 :
        xx = '0' + str(xx)
    else :
        xx = str(xx)
    
    # 호실 앞쪽 번호 : 사람 수 - ((호실 라인 - 1) * 층 수))
    yy = n - ((int(xx) - 1) * h)
    yy = str(yy)
    
    print('앞쪽 번호', yy)
    print('뒷쪽 번호:', xx)
    
    # 호실 번호
    room_number = yy + xx
    
    print(room_number)