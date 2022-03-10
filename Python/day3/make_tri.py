# 삼각형 만들어보기
arr = list(range(9, 0, -1))
for i in arr:
    if i > (len(arr) // 2):
        print(' ' * i, '*' * ((len(arr) - i) * 2 - 1))
    else:
        print(' ' * (len(arr) - i), '*' * (i * 2 - 1))