#!/usr/bin/env python
# coding: utf-8

# In[4]:


# 라이브러리
from selenium import webdriver
from bs4 import BeautifulSoup as bs
import pandas as pd
import os
# 잠깐 쉬기
import time
# 웹의 테이블 형태의 html 데이터를 테이블 형태로 변환해주는 라이브러리
from html_table_parser import parser_functions

# 크롬 드라이버 가져오기
driver = webdriver.Chrome('C:/ChromeDriver_exe/chrome_99_driver.exe')
# 웹크롤링할 사이트 url
url = 'https://www.koreabaseball.com/Record/Team/Defense/Basic.aspx'
# 크롬 드라이버로 url 넣어줌
driver.get(url)
# 동적 웹 페이지의 페이지를 갱신해주는 드롭박스의 태그의 id
tag_id = 'cphContents_cphContents_cphContents_ddlSeason_ddlSeason'


# In[20]:


# 연도
year = 2010


# In[21]:


# find_element_by_id로 드롭박스를 찾고 그 태그에 연도 값을 넣어서 페이지를 갱신해줌 
driver.find_element_by_id(tag_id).send_keys(str(year))


# In[8]:


# 렌더링된 페이지의 요소들을 문자열 형태로 가져오기 
html = driver.page_source
# 문자열 형태로 가져와서 html 형태로 변환하기
soup = bs(html, 'html.parser')


# In[17]:


data = soup.find('table', {'class' : 'tData tt'})
table = parser_functions.make2d(data)
df = pd.DataFrame(data = table)
df.columns = df.iloc[0]
df = df.drop([0]).reset_index(drop = True)
df


# In[75]:


def kbo_record(position, years, path) :
    '''
    position : 데이터를 추출할 포지션(타자 또는 투수 또는 수비 또는 주루)
    years : 데이터를 추출할 연도(2001 이후)
    path : 다운로드받을 경로
    '''
    # 라이브러리
    from selenium import webdriver
    from bs4 import BeautifulSoup as bs
    import pandas as pd
    import os
    import time
    from html_table_parser import parser_functions
    
    # 크롬 드라이버
    driver = webdriver.Chrome('C:/ChromeDriver_exe/chrome_99_driver.exe')
    
    # 웹크롤링할 url
    if position == '타자' :
        url = 'https://www.koreabaseball.com/Record/Team/Hitter/Basic1.aspx'
    elif position == '투수' :
        url = 'https://www.koreabaseball.com/Record/Team/Pitcher/Basic1.aspx'
    elif position == '수비' :
        url = 'https://www.koreabaseball.com/Record/Team/Defense/Basic.aspx'
    elif position == '주루' :
        url = 'https://www.koreabaseball.com/Record/Team/Runner/Basic.aspx'
    
    # 동적 웹 페이지의 페이지를 연도로 갱신해주기 위한 드롭박스 태그의 id
    tag_id = 'cphContents_cphContents_cphContents_ddlSeason_ddlSeason'
    
    # for문으로 입력받은 리스트를 돌면서
    # 입력받은 포지션의 연도별 데이터 웹크롤링하고
    # 입력받은 경로에 csv파일 형태로 다운로드힘
    for year in range(2001, years + 1) :
        # 크롬 드라이버로 url 넣어줌
        driver.get(url)
        # find_element_by_id로 드롭박스를 찾고
        # 그 태그에 연도 값을 넣어서 페이지를 갱신해줌 
        driver.find_element_by_id(tag_id).send_keys(str(year))
        
        # 렌더링된 페이지의 요소들을 문자열 형태로 가져오기 
        html = driver.page_source
        
        # 문자열 형태로 가져와서 html 형태로 변환하기
        soup = bs(html, 'html.parser')
        
        # 태그가 테이블이고 클래스가 tData tt인 요소를 찾기
        data = soup.find('table', {'class' : 'tData tt'})
        
        # html의 테이블을 파이썬의 리스트 형태로 변환하기
        table = parser_functions.make2d(data)
        
        
        # 위에서 변환한 테이블 데이터를 데이터 프레임으로 만들어줌
        df = pd.DataFrame(data = table)
        
        # 전처리
        df.columns = df.iloc[0]
        df = df.drop([0]).reset_index(drop = True)
        
        # 경로 끝에 '/' 있으면 지우기
        if path[-1] == '/' :
            del(path[-1])
            
        # 경로에 csv 파일로 저장
        df.to_csv(f'{path}/{year}년도_{position}_데이터.csv')
        
    # 타자와 투수는 두 페이지로 구성되어 있음
    # 위는 한 페이지만 웹 크롤링, 아래는 두번째 페이지 웹크롤링
    if position == '타자' :
        url = 'https://www.koreabaseball.com/Record/Team/Hitter/Basic2.aspx'
    elif position == '투수' :
        url = 'https://www.koreabaseball.com/Record/Team/Pitcher/Basic2.aspx'
    for year in range(2001, years + 1) :
        driver.get(url)
        driver.find_element_by_id(tag_id).send_keys(str(year))
        html = driver.page_source
        soup = bs(html, 'html.parser')
        data = soup.find('table', {'class' : 'tData tt'})
        table = parser_functions.make2d(data)
        df = pd.DataFrame(data = table)
        df.columns = df.iloc[0]
        df = df.drop([0]).reset_index(drop = True)
        if path[-1] == '/' :
            del(path[-1])
        df.to_csv(f'{path}/{year}년도_{position}_데이터_2.csv')


# In[76]:


while True :
    position = input('1. 데이터를 추출할 포지션을 입력해 주세요(타자 / 투수 / 수비 / 주루) : ')
    if position == '타자' or position == '투수' or position == '수비' or position == '주루':
        try :
            years = int(input('2. 데이터를 추출할 연도들을 입력해주세요(2001년 이후로 입력바랍니다.) : '))
            if years < 2001 :
                print('잘못 입력하셨습니다. 2001년 이후로 입력해주세요.\n')
                continue
            path = input('3. 추출한 데이터를 다운받을 경로를 입력해주세요. : ')
            # 만약 입력받은 경로가 폴더가 아니라면 다시 입력받음
            if os.path.isdir(path) == False :
                print('잘못 입력하셨습니다. 정확한 폴더 경로를 입력해주세요.\n')
                continue
            print('데이터 다운로드를 시작합니다. 시간이 조금 소요될 수 있습니다.')
            break
        except : 
            print('잘못 입력하셨습니다. 정확한 연도를 입력해주세요.\n')
            continue
    else :
        print('잘못 입력하셨습니다. 타자 / 투수 / 수비 / 주루 중 하나를 입력해주세요.\n')

# 함수에 매개변수 전달
kbo_record(position, years, path = path)


# In[69]:


a = 'C:\Users\admin\Desktop\새 폴더'


# In[ ]:




