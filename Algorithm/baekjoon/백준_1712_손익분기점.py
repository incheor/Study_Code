# 처음에 푼 거
# import sys
# input = sys.stdin.readline

# # 고정비, 가변비, 판매가 입력받기
# fc, vc, p = map(int, input().split())

# # 판매 개수
# n = 0

# # while문으로 총 비용과 판매가 계산해서 비교하기
# while True :
#     # 가변비가 판매가보다 높아서 아무리 팔아도
#     # # 손익분기점을 넘기지 못하면 -1 출력
#     if vc > p :
#         print(-1)
#         break
#     # (fc + vc * n) < (p * n) 이면 탈출함
#     if (fc + vc * n) < (p * n) :
#         print(n)
#         break
#     n += 1

# 고정비가 커져니 너무 느려서 다시 푼 거
import sys
input = sys.stdin.readline

# 고정비, 가변비, 판매가 입력받기
fc, vc, p = map(int, input().split())

# 판매 개수
# 가변비와 판매가가 같으면 ZeroDivisionError 떠서 추가함
try :
    n = int(fc / (p - vc) + 1)
    if p - vc < 0 :
        print(-1)
    else :
        print(n)
except : 
    print(-1)