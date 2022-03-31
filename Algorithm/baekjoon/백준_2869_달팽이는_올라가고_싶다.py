import math

A, B, V = map(int, input().split())

V -= B
day = math.ceil(V / (A - B))
print(day)

############## 이건 시간초과날 것 같았음
# # 며칠 걸림?
# day = 1

# # 올라간 높이
# height = 0

# # 낮에는 A미터 올라가고 밤에는 B미터 내려옴
# while True :
#     print('현재 높이:', height)
#     height += A
#     print('올라간 높이:', height)
#     if height >= V :
#         print(day)
#         break
#     height -= B
#     print('내려온 높이:', height)
#     print('#######################')
#     day += 1