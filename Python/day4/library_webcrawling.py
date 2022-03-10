# 웹페이지 크롤링
# 웹이란 request(요청)에 대한 response(응답)를 받는 것

# from urllib.request import Request, urlopen # 파이썬의 표준 라이브러리(따로 설치할 필요 없음)

# req = Request('https://www.naver.com') # naver 웹페이지를 요청
# res = urlopen(req)

# print(res.status) # 웹페이지 상태 보기, 200이 나오면 웹페이지의 request가 정상이다

# 외부 requests 패키지 사용해보기
# 터미널(이나 cmd창에) pip install requests 입력하고 설치
import requests
url = 'https://www.naver.com'
res = requests.get(url)

print(res.status_code)
print(res.text)