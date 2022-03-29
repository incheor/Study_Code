# # 몇번째 분수를 출력할 지 입력받음
# X = int(input())

# # 분자
# ja = 0
# # 분모
# mo = 0
# # 분수
# bunsu = ''
# # while문 count용
# count = 0

# # while문으로 입력받은 휫수만큼만 반복하기
# # 분자와 분모의 수가 서로 바꾸기
# for i in range(X) :
    
#     # 분자가 1이면
#     if ja == 1 :
#         # 오른쪽으로 한칸 이동
#         mo += 1
#         # 분모 -1, 분자 +1
#         # 분모가 1이 될 때까지 반복함
#         while True :
#             mo -= 1
#             ja += 1
#             count += 1
#             if mo == 1 :
#                 break
    
#     # 분모가 1이면
#     elif mo == 1 :
#         # 아래로 한칸 이동
#         ja += 1
#         # 분모 +1, 분자 -1
#         # 분자가 1이 될 때까지 반복함
#         while True :
#             mo += 1
#             ja -= 1
#             count += 1
#             if ja == 1 :
#                 break
    
#     # 입력받은 횟수만큼 반복하면 종료하기
#     if count == X :
#         # 분수 만들기
#         bunsu = str(ja)+ '/' + str(mo)
#         break

# # 출력하기
# print(bunsu)



# 몇번째 분수를 출력할 지 입력받음
X = int(input())

# 기준수
n = 1

# 출력할 분수
bunsu = ''

# for i in range(1, X + 1) :
#     tmp_1 = n
#     tmp_2 = 1
    
#     if n == 1 :
#         n += 1

while True :
    
        
# 기준수가 짝수면
# 분모로는 1 줄이는 임시 변수
# 분자로는 1 늘리는 임시변수
if n % 2 == 0 :
     bunsu = str(tmp_1) + '/' + str(tmp_2)
     print(bunsu)
# 기준수가 홀수면
# 분모로는 1 늘리는 임시 변수
# 분자로는 1 줄이는 임시변수
else :
     bunsu = str(tmp_2) + '/' + str(tmp_1)
     print(bunsu)
     