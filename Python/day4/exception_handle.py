# exception_handle
# try - except
# 에외 처리
def add(a, b):
    return a +b

def sub(a, b):
    return a -b

def mul(a, b):
    return a * b

def div(a, b):
    return a / b

# print('--사칙연산 시작--')
# a, b = 4, 3
# print(f'더하기 결과: {add(a, b)}')
# print(f'  빼기 결과: {sub(a, b)}')
# print(f'곱하기 결과: {mul(a, b)}')
# print(f'나누기 결과: {div(a, b)}')

# print('--사칙연산 종료--')

# print('')
# print('--사칙연산 시작--')
# a, b = 4, 0
# print(f'더하기 결과: {add(a, b)}')
# print(f'  빼기 결과: {sub(a, b)}')
# print(f'곱하기 결과: {mul(a, b)}')
# # print(f'나누기 결과: {div(a, b)}') # 여기와 12번 줄의 div 함수에서 예외 발생: 0으로 나누려고 시도함
# 1번
# try:
#     print(f'나누기 결과: {div(a, b)}')
# except Exception as e: # Exception as e를 붙이면 어떤 예외가 발생했는지 알려줌, e는 예외명을 담는 변수
#     print(f'예외발생! 예외 발생 이유: {e}')
#     print(type(e)) # 이렇게 해도 에러의 객체명이 나옴
# 2번
# try:
#     print(f'나누기 결과: {div(a, b)}')
# except Exception as e:
#     print(f'예외발생! 예외 발생 이유: {e.__str__}') # e.__str__ 하면 에러의 객체명를 알려줌(에러도 객체임)
# 3번, 그런데 이렇게 안 하고 print(type(e)) 해도 에러 객체이름이 나오네?
# try:
#     print(f'나누기 결과: {div(a, b)}')
# except ZeroDivisionError as e: # Exception을 구체적인 ZeroDivisionError로 변경시켜주자
#     print(f'예외발생! 예외 발생 이유: {e}')

# print('--사칙연산 종료--')

print('')
print('--사칙연산 시작--')
a, b = 4, 1
numbers = [3, 6 ,9]
try:
    print(f'나누기 결과: {div(a, b)}')
    res = int(numbers[3]) * 8 # 여기서는 IndexError
    num = int(input('수를 입력하세요')) # 여기서는 숫자말고 다른 거 입력하면 ValueError
except ZeroDivisionError as e:
    print(f'나누기 예외! 예외 발생 이유: {e}')
except IndexError as e:
    print(f'인덱스 예외! 예외 발생 이유: {e}')
except ValueError as e:
    print(f'밸류 예외! 예외 발생 이유: {e}')
except Exception as e:
    print(f'알수없는 예외! 예외 발생 이유: {e}')
finally: # finally는 예외가 발생하든 안하든 무조건 실행해줌, 필수 구문은 아님
    print(f'더하기 결과: {add(a, b)}')
    print(f'  빼기 결과: {sub(a, b)}')
    print(f'곱하기 결과: {mul(a, b)}')

print('--사칙연산 종료--')