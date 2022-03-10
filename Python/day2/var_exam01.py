# 변수
# 파이썬의 변수에는 제약이 거의 없다
a = 'Hello'
print(a)

a = 3.141592
print(a)

a = 99999999999999999999999999999999
print(a)

a = 1 / 10
print(a)

# 변수값을 지정(할당, assign) 방법
a = 3
b = 3.141592
c = 'python'
d = (1, 2, 3) # 이건 튜플
e = [1, 2, 3] # 이건 리스트
f = [4, '5', '$', a]
g = {1, 2, 3} # 파이썬의 장점!!

print(a)
print(b)
print(c)
print(d)
print(e)
print(f)
print(g)

# 변수명
# 영문자(대소문자 구분), 숫자, 언더바
va = 10
va2 = 20
# 3va = 30 숫자로 시작하기 불가
# -va = 40 특수문자 불가 불가(언더바 제외)
v_a = 50
_va = 60
# v a = 70 띄어쓰기 불가

# 변수명은 a, b, c 같은 의미없는 문자의 나열보다는
# 의미있는 단어의 조합으로 만들자
My_Account_of_Bank = 1

print(id(My_Account_of_Bank))
print(type(My_Account_of_Bank))