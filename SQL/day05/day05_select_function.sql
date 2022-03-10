-- 함수 : 문자열
-- concat : 두 문자열을 합침 (|| 이것도 됨)
Select concat('My Name is ', mem_name) 
  From member;
  
-- chr, ascii : ascii 값을 문자로, 문자를 ascii 값으로 변환
Select Chr(65) "CHR", Ascii('A')
  From dual;

-- 회원 테이블의 회원ID 컬럼의 ascii 값을 조회
Select Ascii(mem_id) as 회원Ascii,
       Chr(Ascii(mem_id)) as 회원Chr
  From member;
  
-- Lower : 소문자로 변환
-- Upper : 대문자로 변환
-- Initcap : 첫글자만 대문자로, 나머지는 소문자로 변환
-- 회원 테이블의 회원 ID를 대문자로 변환해 조회
Select Upper(mem_id) as 회원ID
  From member;

-- Ltrim, Rtrim, trim : 공백 문자를 제거
-- 문자열 중간의 공백은 안 지움

-- Substr(c, m, i) : 문자열의 일부를 자르기
-- c문자열의 m문자부터 i번째 문자까지 잘라서 반환

-- Replace(c1, c2, c3) : 문자나 문자열 치환
-- C1에 포함된 c2 문자를 c3값으로 치환
-- c3가 없는 경우 찾은 c2 문자는 제거함
Select Replace('SQL Project', 'SQL', 'SSQQLL') as 문자치환1,
       Replace('Java Flex Via', 'a') 문자치환2
  From dual;

-- 회원 테이블의 회원 이름 중 이씨 성을 리로 치환하고
-- 뒤에 이름을 붙인 후 조회
-- 컬럼은 회원이름, 회원명치환
Select mem_name as 회원이름,
       Concat(
       Replace(Substr(mem_name, 1, 1), '이', '리'), 
       Substr(mem_name, 2, 2)) as 회원명치환
  From member
 Where Substr(mem_name, 1, 1) = '이';


-- 함수 : 숫자
-- Greatest, Least : 열거된 항목 중 가장 큰, 작은 값

-- Round(n, 1) : 지정된 자릿수에서 반올림
-- Trunc(n, 1) : 지정된 자릿수에서 절삭

-- Mod(c, n) : c를 n으로 나누기를 한 후의 나머지값


-- 함수 : 날짜
-- Sysdate : 시스템에서 제공하는 현재 날짜, 시간
Select Sysdate
  From dual;
  
-- Add_months(date, n) : date에 n월을 더한 날짜

-- Next_day(date, n) : date에서 가장 가까운 날짜
-- 일요일(1) ~ 토요일(7)
Select Next_day(Sysdate, 7)
  From dual;

-- Last_day(date) : 해당 월의 가장 마지막 날
Select Last_day(Sysdate)
  From dual;

-- 이번달이 며칠이 남았는지 조회
Select Last_day(Sysdate) - Sysdate
  From dual;
  
-- Extract : 날짜에서 필요한 부분만 추출
-- Extract(Year From date) : 연도만 추출
-- Extract(Month From date) : 월만 추출
-- Extract(Day From date) : 일만 추출
-- 회원 중 생일이 3월인 사람만 조회
Select mem_name,
       mem_bir
  From member
 Where Extract(month From mem_bir) = 3;
 
-- 회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
-- 조회할 컬럼은 상품명이며 상품명에 삼성이 포함되 상품만 조회
-- 조회결과에서 중복은 제거
Select Distinct prod_name as 상품명
  From prod
 Where prod_name Like '%삼성%'
   And prod_id In (
           Select cart_prod
             From cart
            Where cart_member In (
                          Select mem_id
                            From member
                           Where Extract(Year From mem_bir) =  1973));