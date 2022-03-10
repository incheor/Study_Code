# while문
print('--while문--')
hit = 0
while hit < 100: # 이 값이 True인 동안
    hit += 1
    if hit > 10: # 10번 찍으면 종료
        break
    print(f'나무를 {hit}번 찍습니다.')


print('')
print('--for문으로 바꾸기--')
for i in range(1, 101):
    if i > 10:
        break
    print(f'나무를 {i}번 찍습니다.')

print('')
print('--while문 무한루프--')
# while문 무한루프
val = 0
print('회원정보 프로그램')
while True:
    print('''작업할 번호를 선택하세요.
    1. 회원입력
    2. 회원검색
    3. 회원수정
    4. 회원삭제
    5. 종료
    숫자 입력: ''', end = '')
    val = int(input()) # 입력, 입력이 들어올 때가지 작업은 일시정지
    # 정수로 받기 때문에 만일 다른 자료형의 값을 입력하면 오류남, 예외처리 해줘야 한다
    if val == 1:
        print('회원정보화면으로 이동')
    elif val == 2:
        print('회원검색화면으로 이동')
    elif val == 3:
        print('회원수정화면으로 이동')
    elif val == 4:
        print('회원삭제화면으로 이동')
    elif val == 5: # 5를 입력하면 무한루프 종료
        break
    else:
        print('1부터 5사이의 정수를 입력하세요.')
        continue
print('회원정보 프로그램 종료')