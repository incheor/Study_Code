# 컴퓨터 <-- 사용자 : 출력
# 컴퓨터 --> 사용자 : 입력
# 파일 입출력
# w : 쓰기모드, 파일에 내용을 쓸 때 사용, 파일이 없으면 새파일을 만든다
# r : 읽기모드, 파일을 읽어올 때 사용
# a : 추가모드, 파일에 내용을 추가할 때 사용
# 다른 특정 경로를 넣어줄 때는 역슬래시 두 번 써줘야 함(\\ 이렇게)
# ASCII(영어만 처리)와 cp949(=EUC-KR, 한글처리), UTF-8(모든 언어)
# open 했으면 close() 꼭 하기

# 파일 쓰기 기본
# f = open('C:\\Souuces\\Sample\\test.txt', 'w') # w : 쓰기모드, 파일이 없으면 새로 만들어줌
# f.close() # close 잊지말자
# print('파일이 생성되었습니다') # 알려주기

# newfile.txt 파일 읽어오기(입력)
# f = open('newfile.txt', 'r', encoding='utf-8') # encoding='utf-8' 추가해주기
# print('--while문으로 한 줄 씩 읽기--')
# while True:
#     line = f.readline()
#     if not line: # 더이상 라인이 없으면 무한루프 탈출
#         break
#     print(line)
# print('--for문으로 한 번에 다 읽기--')
# lines = f.readlines() # 이렇게 하면 한 번에 다 읽어서
# print(type(lines)) # 리스트에 넣어줌
# for line in lines:
#     print(line)
# f.close()

# print('--간단한 방법--')
# # 간단한 방법
# for line in f:
#     print(line.replace('\n',"")) 
# f.close()

# # 파일 쓰기
# f = open('writefile.txt', 'w', encoding='utf-8')

# f.write('저는 한국사람입니다.\n') # 이렇게 하면 한 줄 쓰기

# texts = ['저는 한국사람이죠\n', '올해는 2022년입니다\n'] # 이렇게 하면 여러 줄을 한 번에
# f.writelines(texts)

# f.close()

# # 내용 추가
# f = open('writefile.txt', 'a', encoding='utf-8') # 추가할 때는 a
# f.write('내용 추가할게요!')
# f.close()