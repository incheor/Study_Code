S = input()
S = S.upper()
S_temp = list()
S_list = list()

for i in range(0, len(S)) :
    count = 0
    for j in range(0, len(S)) :
        if S[i] == S[j] :
            count = count + 1
    S_temp.append(S[i])
    S_temp.append(count)
print(S_temp)

for i in range(0, len(S_temp), 2) :
    print(S_temp[i], S_temp[i + 1])