#!/usr/bin/env python
# coding: utf-8

# In[1]:


# 라이브러리
from bs4 import BeautifulSoup as bs
import requests
from selenium import webdriver
import urllib.request
from html_table_parser import parser_functions
import pandas as pd
import os

driver = webdriver.Chrome('C:/ChromeDriver_exe/chrome_99_driver.exe')

# 크롤링할 url
# 타자 : http://www.statiz.co.kr/stat.php?opt=0&sopt=0&re=0&ys={year}&ye={year}&se=0&te=&tm=&ty=0&qu=auto&po=0&as=&ae=&hi=&un=&pl=&da=1&o1=WAR_ALL_ADJ&o2=TPA&de=1&lr=5&tr=&cv=&ml=1&sn=30&si=&cn=
# 투수 : http://www.statiz.co.kr/stat.php?opt=0&sopt=0&re=1&ys={year}&ye={year}&se=0&te=&tm=&ty=0&qu=auto&po=0&as=&ae=&hi=&un=&pl=&da=1&o1=WAR&o2=OutCount&de=1&lr=5&tr=&cv=&ml=1&sn=30&si=&cn=
# 수비 : http://www.statiz.co.kr/stat.php?opt=0&sopt=0&re=2&ys={year}&ye={year}&se=0&te=&tm=&ty=0&qu=auto&po=0&as=&ae=&hi=&un=&pl=&da=1&o1=FR_WAR&o2=OC&de=1&lr=5&tr=&cv=&ml=1&sn=30&si=&cn=


# In[2]:


# 웹크롤링 함수
def year_team_score(position, years, path) :
    '''
    position : 데이터를 추출할 포지션(타자 또는 투수 또는 수비)
    years : 해당 연도까지 추출함(2002 이상의 정수)
    path : 데이터를 추출해 다운받을 경로(경로 끝의 '/' 는 빼고 입력)
    '''
    # 포지션별 웹사이트 url 딕셔너리
    dict_position = {
        '타자' : 'http://www.statiz.co.kr/stat.php?opt=0&sopt=0&re=0&ys={}&ye={}&se=0&te=&tm=&ty=0&qu=auto&po=0&as=&ae=&hi=&un=&pl=&da=1&o1=WAR_ALL_ADJ&o2=TPA&de=1&lr=5&tr=&cv=&ml=1&sn=30&si=&cn=',
        '투수' : 'http://www.statiz.co.kr/stat.php?opt=0&sopt=0&re=1&ys={}&ye={}&se=0&te=&tm=&ty=0&qu=auto&po=0&as=&ae=&hi=&un=&pl=&da=1&o1=WAR&o2=OutCount&de=1&lr=5&tr=&cv=&ml=1&sn=30&si=&cn=',
        '수비' : 'http://www.statiz.co.kr/stat.php?opt=0&sopt=0&re=2&ys={}&ye={}&se=0&te=&tm=&ty=0&qu=auto&po=0&as=&ae=&hi=&un=&pl=&da=1&o1=FR_WAR&o2=OC&de=1&lr=5&tr=&cv=&ml=1&sn=30&si=&cn='
    }
    
    # 포지션별 필요한 url 변수 만들기
    url = dict_position[position]
        
    # 2001년부터 매개변수로 받은 연도까지 리스트로 만들기
    list_years = [i for i in range(2001, years + 1)]
    
    # 연도별 데이터 추출하기
    for year in list_years :
        # 포지션별 웹사이트 url에 연도 포맷팅
        url = url.format(year, year)
        # url에 연결하기
        driver.get(url)
        # 렌더링된 페이지의 요소들을 문자열 형태로 가져오기
        html = driver.page_source
        # 문자열 형태로 가져와서 html 형태로 변환하기
        soup = bs(html, 'html.parser')
        # 태그가 테이블이고 아이디가 mytable인 요소를 찾기
        data = soup.find('table', {'id' : 'mytable'})
        # html의 테이블을 파이썬의 리스트 형태로 변환하기
        table = parser_functions.make2d(data)
        # 위에서 변환한 테이블 데이터를 데이터 프레임으로 만들어줌
        df = pd.DataFrame(data = table)
        # 경로 끝에 '/' 있으면 지우기
        if path[-1] == '/' :
            del(path[-1])
        # 경로에 csv 파일로 저장
        df.to_csv(f'{path}/{year}년도_{position}_데이터.csv')


# In[3]:


while True :
    position = input('1. 데이터를 추출할 포지션을 입력해 주세요(타자 / 투수 / 수비) : ')
    if position == '타자' or position == '투수' or position == '수비' :
        try :
            years = int(input('2. 데이터를 추출할 연도를 입력해주세요(2001년부터 입력하신 연도까지 데이터를 추출합니다.) : '))
            if years <= 2001 :
                print('잘못 입력하셨습니다. 2002년 이후로 입력해주세요.\n')
                continue
            path = input('3. 추출한 데이터를 다운받을 경로를 입력해주세요. : ')
            if os.path.isdir(path) == False :
                print('잘못 입력하셨습니다. 정확한 폴더 경로를 입력해주세요.\n')
                continue
            print('데이터 다운로드를 시작합니다. 시간이 조금 소요될 수 있습니다.')
            break
        except : 
            print('잘못 입력하셨습니다. 정확한 연도를 입력해주세요.\n')
            continue
    else :
        print('잘못 입력하셨습니다. 타자 / 투수 / 수비 중 하나를 입력해주세요.\n')
        
# year_team_score(position, years, path)


# In[4]:


year_team_score(position, years, path)


# In[ ]:




