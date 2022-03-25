import sys

# input보다 sys.stdin.readline이 더 빨라서 이거 씀
input = sys.stdin.readline

# 입력받을 문자열 횟수
n = int(input())

# 문자열을 입력받아서 넣어놓을 리스트
list_s = list()

# 그룹단어 개수 세는 용
count = 0

# 반복문으로 위에서 입력한 횟수만큼 입력받아서 리스트에 넣음
for i in range(n) :
    tmp = input().split()
    # split()을 쓰면 리스트로 변환되서 풀어주기
    s = tmp[0]
    # 입력받은 문자열을 리스트에 넣기
    list_s.append(s)

# 문자열 리스트에서 문자열을 하나씩 꺼내기
for s in list_s :
    # 중복 확인용 임시 리스트
    tmp_list = list()
    # 문자열에서 문자를 하나씩 꺼내기
    for i in range(len(s) - 1) :
        # 문자를 비교해서 다르고
        if s[i] != s[i + 1] :
            # 중복 확인용 tmp_list에 없으면 리스트에 넣기
            if s[i] not in tmp_list :
                tmp_list.append(s[i])
            # 중복 확인용 리스트에 있으면 
            # 단어가 또 나온 것이므로 그룹단어가 아님
            elif s[i] in tmp_list:
                # tmp_list를 비우고 안쪽 반복문 종료
                tmp_list = list()
                break
    # tmp_list의 길이가 0이 아니면 그룹단어임
    if len(tmp_list) != 0 :
        count += 1
        
# 그룹단어 개수 출력
print(count)