h, m = map(int, input().split())
t = int(input())

h = h + t // 60
m = m + t % 60

if m >= 60 :
    h = h + 1
    m = m -60

if h >= 24 :
    h = h % 24
elif h < 24 :
    h = h

print(h, m)