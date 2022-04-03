# Study_Code
공부한 코드들
- PL/SQL
- R
- Python(+JupyterNotebook)
- Algorithm
- web : Flask

## PL/SQL
### 1일차 학습
- Oracle 소개 및 설치
- SQL Developer 설치와 사용법 학습
- SQL 기본 SELECT문 학습

### 2일차 학습
- WHERE
- AND, OR, BETWEEN AND, IN
- Alias(별칭)
- LIKE(%, _)
- 집합
- 여러 함수들
- GROUP BY와 HAVING

### 3일차 학습
- 조인: INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN
- INSERT INTO + VALUES
- UPDATE + SET + WHERE
- DELETE + WHERE
- SEQUENCE
- SUBQUERY

### 4일차 학습
- 데이터 베이스 이론 기초
- Select 복습

### 5일차 학습
- 연산자들 복습
    - Or, And
    - In, Between
    - Like와 %
- 서브쿼리 기초
- 함수들 복슴
    - 문자열 함수(문자열 합치기, 대소문자 변환, 공백제거, 문자열 일부 자르기, 문자열 치환하기)
    - 숫자와 날짜(Sysdate, Extract)
    - 형변환(To_char, To_number, To_date)
    - 그룹 함수(Avg, Count)

### 6일차 학습
- 함수들 복습
    - 그룹함수(count, max, min, sum)
    - having : gruop by의 조건절
    - NULL함수
    - Decode와 Case
- 문제 만들어보며 복습

### 7일차 학습
- Join 복슴 : 일반 방식, 국제 표준 방식
 - Cross Join, Inner Join
- 다른 조의 문제를 풀어보면서 복습

### 8일차 학습
- Join 복습 : Left Outer Join을 중심으로
- Having : Group 함수의 조건을 기술
- subquery
    - Any / All
    - subquery연습
- left outer join & sub query 변환 연습

## R
### 1일차
- R의 자료형 구분(factor를 중심으로)
    - factor란 범주형 데이터를 다룰 때 주로 사용, 집계(count)의 의미 O, factor로 변환하는 방법은 as.factor()를 사용하면 된다
- R의 자료구조
    - 1차원 자료구조: vector, list, factor
    - 2차원 자료구조: matrix, data frame
- 기본 함수

### 2일차
- 데이터 프레임과 리스트의 인덱싱 연습
- R의 라이브러리: naniar, VIM, Amelia
- 데이터 전처리 맛보기
    - 공공데이터포털에서 csv 파일 활용
    - R의 라이브러리로 NA값을 이미지화

### 3일차
- 데이터 전처리 연습
    - tips, mtcars 내장 데이터 세트 활용
    - head, str, class, summary로 해당 자료 파악
    - is.na로 NA값 보기
    - PerformanceAnalytics 라이브러리와 plot, boxplot, cor로 상관도 보기
    - subset으로 데이터 분리 
- for문으로 인덱싱을 자동화해보기

### 4일차
- 데이터 전처리 연습
- 여러 라이브러리들
    - wordcloud, lubridate, ggplot2, plyr
- 그래프로 출력하기

### 5일차
- 데이터 가공
    - 추출 : ifelse
    - dplyr 라이브러리(%>%) 활용해서 추출 : filter, select

### 6일차 
- dplyr 라이브러리로 데이터 가공
    - 정렬 : arrange
    - 요약 : group_by + summarise
    - 합치기 : left_join, bind_rows
- dplyr 라이브러리로 데이터 정제
    - 결측치 확인 및 관리
    - 이상치 확인 및 대체
- 그래프 : ggplot2 라이브러리 필요
    - 그래프 배경 그리기 : ggplot(data = 데이터 세트, aes(x = 변수명, y= 변수명))
    - 산점도 : geom_point()
    - 막대그래프 : geom_col()
    - 빈도수 막대그래프 : geom_bar()

### 7일차
- 그래프
    - 선 그래프 : geom_line()
    - 상자 그림 : geom_line()
- 데이터 분석 연습 : 변수 검토 및 전처리와 변수 간 관계 분석
    - 한국인복지패널데이터 활용
- 텍스트 마이닝 시작 전 KoNLP 라이브러리 설치를 위한 설정
    - JDK 설치 및 환경변수 설정, Rtools 환경변수 설정
    - usethis 라이브러리 설치, usethis::edit_r_environ() 입력후 창에서 PATH="${RTOOLS40_HOME}/usr/bin;${PATH} 입력하고 창 닫고 Sys.which('make') 입력
    - rJava, remotes 라이브러리 설치, remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch")) 입력

### 8일차
- 텍스트 마이닝
    - KoNLP 라이브러리 활용
    - stringr 라이브러리로 특수문자 제거
    - RColorBrewer 라이브러리오 색상 변경
    - wordcloud 라이브러리로 시각화
    - 대통령 연설문 텍스트 마이닝
- 지도 시각화
    - 미국 주별 강력 범죄율 시각화
    - 대한민국 시도별 결핵 환자 수 시각화
    - 지도 시각화 연습
        - left_join 활용해보기

### 9일차
- R과 Oracle DB 연동하고 사용해보기 기초
- 데이터 수집
    - 파일 데이터 세트
    - 웹 크롤링
        - 웹 크롤링 연습
    - 오픈 API
        - 오픈 API 연습

## Python
### 1일차
 - 프로그래밍 이해
 - 파이썬 설치, vs code 설치
 - 개발환경 구축
 - 기본 문법
    - 콘솔 출력 print()
    - 주석 #
    - 변수 사용해보기
    - type() 함수
    - 형 변환
    - 연산자 우선순위
    - import로 라이브러리 불러오기 맛보기(math)

    ### 2일차
    - 변수형
    - 자료형
    - 자료구조
      - 리스트
      - 튜플
      - 딕셔너리
      - 세트
   -각 자료구조별 연산

   ### 3일차
   - 흐름제어(if, for, while)
      - 별로 다이아몬드 모양 출력해보기
   - 뱐수의 라이프스코프(지역변수, 전역변수)
   - 함수와 여러 형태의 함수
   - 객체지향의 기본 개념과 클래스의 기본 구조
      - 특성(명사) --> 속성(변수)
      - 행동(동사) --> 메서드(함수)
   - 모듈과 패키지 기본

   ### 4일차
   - 모듈과 패키지
      - 표준 라이브러리: math, random, urllib의 request
      - 외부 라이브러리: requests
   - 입출력(input/output)
   - 파일 입출력
   - 예외처리
   - 디버깅

   ### 5일차
   - cx_Oracle 라이브러리 활용
   - 파이썬으로 Oracle DB CRUD 코딩

   ### 6일차
   - Jupyter Notebook 사용법
   - class
      - 멤버변수, 멤버함수
      - 객체생성
      - 클래스 사용
      - 생성자
      - 매직메서드

   ### 7일차
   - 데이터 전처리를 위한 여러 라이브러리들 공부
     - numpy 라이브러리를 이용한 배열 연산
     - image 라이브러리의 pillow 모듈을 활용한 이미지 처리
     - os(os.listdir), glob 라이브러리로 폴더 내 자료를 리스트화
     - shutil(shutil.copytree) 라이브러리로 폴더내 자료 복제
   - 리스트 연습

## 파이썬 WEB
- 장고(Django)
    - 풀스택 에디션
    - 스프링(Spring)
    - 프레임워크 : 내맘대로 짤 수 없고 정해진 룰로 짜야함
- 플라스크(Flask)
    - 마이크로 에디션
    - 노드(Node)
    - 자유도가 높고(머신러닝/딥러닝 모듈을 이식하기 쉬움) 코드가 짧음 -> 공식 가이드가 없음

### 개요
- 플라스크 기반 웹 서비스
- 머신러닝 모델을 적용한 서비스
- 파파고 유사 형태 제공

### 사전 지식
- 웹 분야 중 클라이언트 구성은 3개
    - html5 : 뼈대, 컨텐츠
    - css3 : 디자인, 레이아웃, 데코레이터, 반응형(애니메이션)
    - javascript : 이벤트, ajax(비동기 네트워크), 화면조작(동적 화면 구성)
- 클라이언트가 서버로 데이터를 전송하는 방법
    - form 전송 : 주소창 옆의 새로고침 아이콘이 X로 잠깐 변경됐다가 새로고침됨
    - ajax 전송 : 화면 변화는 없음. 응답결과로 변경할 수는 있지만 화면은 고정되어 있음