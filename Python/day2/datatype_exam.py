# 자료형
# None
print(None)
print(type(None)) # None도 타입이다
print(0 == None) # 0은 None이 아니다

a = None
print(a)
print(type(a))

# 숫자형
won = 12_345_678 # 숫자 입력할 때 언더바 넣으면 알기 쉬움, 출력은 안 됨
print(won)

# 문자열형
bruce_eckel = 'Life is short, You need Python.'
print(bruce_eckel)

bruce_eckel = 'Life is short,\nYou need Python.' # 줄바꿈 할 때는 \n(\: 이스케이프 문자)
print(bruce_eckel)

bruce_eckel = '''Life is short,
You need Python.''' # 아니면 홑따옴표 3개 쓰면 입력한 대로 줄바꿈 됨
print(bruce_eckel)

# bool형(불리안, 불린, 불): 참, 거짓
val_sum = 1000
print(val_sum == 1000) # True
print(val_sum == 900)  # False

bl_true = True # bool타입도 할당 가능
print(bl_true)
print(type(bl_true))
print(bl_true == True)
print(bl_true is True) # is 도 사용 가능
print(val_sum is 1000) # is 도 사용 가능2

print(bool(1)) # bool에서 1은 True
print(bool(0)) # bool에서 0은 False

# 리스트
a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(a)

a = [i for i in range(10)]
print(a)

a = ['Life', 'is', 'short', 'You', 'need', 'Python']
print(a)

# 2차원 리스트
a = [[1, 2, 3], [4, 5, 6]]
print(a)

# 빈 리스트 만들기, None 아님
a = []
print(a)
a = list()
print(a)

# 튜플
tuple = (1, 2, 3, 4, 5)
print(tuple)

# 딕셔너리
spiderman = {'name' : '피터파커', 'age' : 18, 'weapon' : '웹슈터'}
print(spiderman)

# 세트
set_int = set([1, 2, 3, 3, 4, 5, 6, 6, 7])
print(set_int)