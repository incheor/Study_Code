# 함수 선언 및 사용

# 기본 형태
# 더하기 함수 선언
def add(a, b):
    result = a + b
    return result

print('두 수의 합은', add(3, 4))

# 함수 종류
print('')
print('--매개변수(입력값)가 없는 경우--')
# 매개변수(입력값)가 없는 경우
def say_hello():
    return 'Hello'

print(say_hello(), 'my friend')

# 함수의 결과값을 변수에 넣는 것도 가능
val = say_hello()
print(val.replace('ello', 'i'))

print('')
print('--리턴값이 없는 경우--')
# 리턴값이 없는 경우
# return None이 생략된 거
def say_hello(name):
    print(f'Hello {name}')

say_hello('홍길동')

print('')
print('--둘 다 없는 경우--')
# 둘 다 없는 경우
def say_goodbye():
    print('Bye bye')

say_goodbye()

print('')
print('--매개변수를 지정하는 경우--')
# 매개변수를 지정하는 경우
def multi(a, b):
    return a * b

print(multi(3, 8))

print('')
print('--매개변수 갯수가 가변적인 경우--')
# 매개변수 갯수가 가변적인 경우
def plus(*a):
    result = 0

    for i in a:
        result += i

    return result

print(plus(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))

print('')
print('--리턴값이 두 개 이상인 경우--')
# 리턴값이 두 개 이상인 경우
def mul_and_div(x, y):
    mul = x * y
    div = x / y

    return (mul, div) # 리턴값의 자료형은 튜플

(res1, res2) = mul_and_div(7, 8)
print(res1, res2)
print(type(mul_and_div(7, 8)))

def 사칙연산(x ,y):
    return(x+y, x-y, x*y, x/y)

res1, res2, res3, res4 = 사칙연산(9, 5)
print(res1, res2, res3, res4)