# 기본 if문
name = '홍길동'

if name == '홍길동' or name == '태경':
    print(f'{name} 씨 의사를 만나러 오세요.')
elif name == '다원':
    print('주사실로 가세요.')
else: 
    print('호출할 때까지 대기하세요.')

print('')
print('--리스트 if문--')
# 리스트나 튜플 등 활용
names = ['명건', '태경', '기영', '광조']
if '명건' in names:
    print('의사를 만나러 오세요.')
else:
    print('대기해 주세요.')

print('')
print('--중첩 if문--')
# 중첩 if문
x = 9

if x > 0:
    print('양수')
    if x > 9:
        print('10보다 큰 수')
    else:
        print('10보다 작은 수')
elif x == 0:
    print('0')
else:
    print('음수')