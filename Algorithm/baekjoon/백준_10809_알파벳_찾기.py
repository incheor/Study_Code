import sys

input = sys.stdin.readline

# 단어를 입력받음
S = input()
# 입력받은 단어를 비교할 리스트
list_a = ['a', 'b', 'c', 'd', 'e', 'f', 'g',
          'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
          'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
# 몇번째에 위치하는지 저장하는 리스트
list_S = list()

# list_a에서 하나씩 꺼내서 입력받은 문자열의 위치를 확인하고 list_S에 추가
for i in range(0, len(list_a)) :
    count = 0
    for j in range(0, len(S)) :
        count = count + 1
        if list_a[i] == S[j] :
            list_S.append(j)
            break
        elif count == len(S) :
            list_S.append(-1)
            
for i in range(0, len(list_S)) :
    print(list_S[i])