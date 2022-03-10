H, M = map(int, input().split())

M = M - 45
if M < 0 :
    H = H -1
    M = 60 + M
    if H < 0 :
        H = 23
print(H, M)