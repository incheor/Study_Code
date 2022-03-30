# 문자열 입력하고 대문자로 변경
S = input().upper()

# 각 알파벳의 갯수를 저장할 리스트
S_c = []

# 문자열에서 알파벳을 하나씩 가져옴
for s_1 in S :
    # 알파벳의 갯수를 세는 변수
    c = 0
    # 가져온 알파벳을 문자열의 각 알파벳과 비교함
    for s_2 in S :
        # 일치하면 count + 1
        if s_1 == s_2 :
            c += 1
    #  count한 후 S_c 리스트에 넣음
    S_c.append(c)

# 문자열에서 가장 많은 알파벳의 갯수를 저장할 변수
m_c = 0

# 문자열에서 가장 많은 알파벳을 저장할 변수
m_s = 'a'

# 문자열에서 가장 많은 알파벳 갯수 찾기
for i in range(len(S)) :
    # m_c 해당 알파벳의 갯수보다 작으면 m_c, m_s 그 값으로 변경함
    if m_c < S_c[i] :
        m_c = S_c[i]
        m_s = S[i]

# m_c 각 알파벳의 갯수 비교함
for i in range(len(S)) :
    # m_c(최대갯수)와 알파벳의 갯수가 일치하고
    # m_s(최대갯수의 앞파벳)와 알파벳이 일치하지 않으면
    if m_c == S_c[i] and m_s != S[i] :
        # ?를 출력하고 종료
        print('?')
        break
    
    # 마지막까지 반복했는데 위의 조건문에 안 걸리면
    if i == len(S) - 1 :
        # 최대갯수의 알파벳을 출력
        print(m_s) 