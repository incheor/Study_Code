import sys

# 문자열 입력받기
S = sys.stdin.readline()

# 문자열 인덱싱용
i = 0

# 크로아티아 알파벳 count용
c = 0

# 크로아티아 알파벳 리스트
ca_list = ['c=', 'c-', 'dz=', 'd-', 'lj', 'nj', 's=', 'z=']

# 크로아티아 알파벳이 있으면 count
while True :
    # 앞에서 2글자 추출해서 비교하기
    # 같으면 count +1, index +2
    if S[i : i + 2] in ca_list :
        print(S[i : i + 2])
        i += 2
        c += 1
    # 앞에서 3글자 추출해서 비교하기
    # 같으면 count +1, index +3
    elif S[i : i + 3] in ca_list :
        print(S[i : i + 3])
        i += 3
        c += 1
    # 크로아티어 알파벳이 아닌 경우
    else :
        print(S[i])
        i += 1
        c += 1
    
    # 문자열 최대 인덱스를 넘어가면 종료하기
    if i >= len(S) - 1 :
        break
    
print(c)