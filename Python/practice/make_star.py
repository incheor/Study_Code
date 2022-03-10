# 별모양
# 다이아몬드 모양
number1 = int(input('숫자를 입력하세요: '))
print('--다이아몬드 모양--')
for i in range(1, number1 + 1):
    if i < number1 // 2:
        print(' ' * (number1 - i) + '*' * (i * 2 - 1))
    else:
        print(' ' * i + '*' * ((number1 - i) * 2 - 1))

# 나비 모양
number2 = int(input('숫자를 입력하세요: '))
print('--나비 모양--')
for i in range(1, number2 + 1):
    if i < number2 // 2:
        print('*' * i + ' ' * ((number2 - i) * 2 - number2) + '*' * i)
    else:
        print('*' * (number2 - i) + ' ' * (i * 2 - number2) + '*' * (number2 - i))

# 모래시계 모양
number3 = int(input('숫자를 입력하세요: '))
print('--모래시계 모양--')
for i in range(1, number3 + 1):
    if i < number3 // 2:
        print(' ' * i + '*' * ((number3 - i) * 2 - number3 - 1))
    else:
        print(' ' * (number3 - i) + '*' * (i * 2 - number3 - 1))