# 변수의 라이프스코프
a = 10

def vartest(a): # 여기서 만들어진건 밖에서는 못 씀
    a += 1
    return a

res = vartest(a)
print(res)