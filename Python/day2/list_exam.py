# 리스트
arr = list(range(5)) # 이렇게 하면 0부터 만들어 진다
print(arr)

arr = list(range(1, 6)) # 이렇게 하면 1부터 만들 수 있다
print(arr)

arr = list(range(2, 101, 2)) # 2씩 증가하는 리스트
print(arr)

print(arr[0] + arr[5])

# 이중 리스트(==이차원 배열)
arr2 = [1, 2, ['Hi', 'My', 'Friend']]
print(arr2[0])
print(arr2[2])
print(arr2[2][2])
print(arr2[2][2][2])

arr3 = list(range(1, 4))
print(arr3 * 3) # * 는 리스트를 반복시킴
print(arr3 + arr) # + 는 리스트끼리 붙인다
print(len(arr3)) # 리스트 요소의 갯수 세준다

# 리스트 함수
print('--리스트 내장함수--')

#지우기
arr4 = [4, 2, 6, 9, 12 ,16, 7, 1, 3, 3, 5]
arr4.remove(3) # 3이라는 값을 찾아서 지움, 최초의 1개만 지운다
print(arr4)

del(arr4[8]) # 8번째 인덱스의 값 3을 지움
print(arr4)

# 정렬
arr4.sort() # 올림차순으로 정렬
print(arr4)

arr4.reverse() # 내림차순으로 정렬
print(arr4)

# 값 추가
print('--값 추가--')
arr4.insert(2, 10) # 해당 인덱스에 해당 값 추가, 뒤에 있는 값은 뒤로 밀림
print(arr4)

arr4[0] = 108 # 이렇게도 추가할 수 있음
print(arr4)

arr4.append(30) # append는 리스트의 마지막에 값을 추가해준다
print(arr4)

print('--튜플--')
# 튜플
tup1 = tuple(range(1, 6))
print(tup1)

# 이미 만들어진 튜플은 값을 할당하거나 수정하거나 삭제가 불가능하다
# tup1[0] = 99 # 할당 불가
# print(tup1)

# 리스트와 튜플 변환
print('--리스트와 튜플 변환--')
print(arr4)
tup2 =tuple(arr4) # 리스트를 튜플로
print(tup2)

print(tup1)
arr5 = list(tup1) # 튜플을 리스트로
print(arr5)

print('--딕셔너리--')
# 딕셔너리
dic1 = {1 : 'a'}
dic1[2] = 'b' 
dic1['sing'] = 'song' # 딕셔너리는 키가 숫자가 아니라 문자열도 가능하다
dic1['name'] = '홍길동'
print(dic1)

# 딕셔너리의 값을 지울 때는 인덱스 대신 키를 사용한다
del dic1['sing']
print(dic1)

# 키만 출력
print(dic1.keys())

# 값만 출력
print(dic1.values())

# 쌍으로 출력
print(dic1.items())