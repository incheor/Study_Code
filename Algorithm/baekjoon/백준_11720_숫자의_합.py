# N개의 숫자가 공백 없이 쓰이고 숫자를 모두 합해서 출력
# 첫째 줄에 숫자의 개수 N이 주어지고 둘째 줄에 숫자 N개가 공백없이 주어짐
import sys

n = int(input())
list_n = list(range(n))
list_n = list(sys.stdin.readline().strip(''))
sum = 0
for i in range(0, n) :
    sum = sum + int(list_n[i])
print(sum)