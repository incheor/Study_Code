# for문
print('--리스트로 for문--')
# 리스트로 for문
arr = list(range(1,11)) # 1부터 11까지 만들기

for i in arr:
    print(f'{i:1.1f}') # 정수를 실수로 출력하기

print('')
print('--튜플로 for문--')
# 튜플로 for문
arr2 = ('me', 'my', 'friend', 'jane')

for item in arr2:
    print(item)

for item in arr2:
    print(f'{item:>10}') # 이렇게 하면 출력할 때도 들여쓰기 돼서 나온다(숫자도 가능)

print('')
print('--for문으로 합계 구하기--')
# for문으로 합계 구하기
numbers = list(range(1, 21, 2)) # 1 ~ 20 까지의 정수 중 홀수만
sum = 0
for item in numbers:
    sum += item
print(f'{numbers[-1]}까지의 총 합은 {sum} 입니다.')

print('')
print('--for문과 if문--')
numbers = list(range(1, 11)) # 1 ~ 10 까지의 정수

print('--홀수짝수 구분--')
# 홀수짝수 구분
for item in numbers:
    if item % 2 != 0:  # 홀수만
        print(f'{item}은 홀수')

print('')
print('--break--')
# break: break문을 만나면 for문에서 탈출함
# # 1부터 10의 정수를 출력하는데 8에서 탈출하는 반복문
for item in numbers:
    if item == 8: 
        print('8이라서 탈출합니다.')
        break  # 8에서 탈출
    print(item)

print('')
print('--continue--')
# contunue: continue문을 만나면 for문의 위로 올라감
# 1부터 10의 정수를 출력하는데 4와 5를 만나면 건너뛰기
for item in numbers:
    if item == 4 or item == 5: 
        continue # 4와 5는 건너뛰기
    print(item)

print('')
print('--구구단 만들어 보기--')
# 이중 for문으로 구구단 만들기
for i in range(2, 10): # 2 ~ 9까지
    if i == 4: # 4단 만나면 continue
        print('4단은 스킵합니다.')
        continue
    if i == 8: # 8단 만나면 break
        print('8단 이후로는 안 외울래')
        break
    print(f'{i}단!!')
    for j in range(1, 10): # 1 ~ 10까지
        print(f'{i} X {j} = {i * j:2d}', end =' ')
        # 숫자와 d를 붙이면 띄어쓰기와 줄맞춤이 된다
        # print는 기본적으로 줄바꿈이 되지만 end 옵션은 한 줄로 출력할 수 있다
    print('')

print('')
print('--인라인 for문--')
# 인라인 for문
a = [1, 2, 3, 4]
result = [i * 3 for i in a]
print(result)

# 기존 for문(결과는 위와 동일)
b = list()
for i in range(1, 5):
    b.append(i * 3)
print(b)