import sys

# 문자열 입력받기
S = sys.stdin.readline()

# 입력받은 문자와 비교할 다이얼
D = {
    3 : ['A', 'B', 'C'],
    4 : ['D', 'E', 'F'],
    5 : ['G', 'H', 'I'],
    6 : ['J', 'K', 'L'],
    7 : ['M', 'N', 'O'],
    8 : ['P', 'Q', 'R', 'S'],
    9 : ['T', 'U', 'V'],
    10 : ['W', 'X', 'Y', 'Z'],
}

# 시간
second = 0

# 입력받은 문자열에서 하나씩 꺼내기
for s in S :
    # items()로 다이얼의 value를 꺼내기
    for d_k, d_v in D.items() :
        # value 리스트에서 하나씩 꺼내면서 문자와 비교하기
        for v in d_v :
            if s == v :
                second += d_k
                break

# 시간 출력하기
print(second)