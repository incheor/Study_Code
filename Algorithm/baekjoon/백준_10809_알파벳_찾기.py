import sys

input = sys.stdin.readline

# 단어를 입력받음
S = input()
# 입력받은 단어를 비교할 리스트
list_a = ['a', 'b', 'c', 'd', 'e', 'f', 'g',
          'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
          'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

# list_a에서 하나씩 꺼내서 문자열에 그 문자가 있는지 확인
# 있으면 count 하고 list_count에 추가
for i in range(0, len(list_a)) :
    # 단어에서 해당 문자의 갯수를 카운트
    count = 0
    for j in range(0, len(S)) :
        # 해당 문자가 있으면 count + 1
        if list_a[i] == S[j] :
            count += 1
    print(count)