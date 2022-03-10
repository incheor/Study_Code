-- 상품정보에서 판매가격의 평균값을 조회
-- 평균값은 소수전 2번째 자리까지 표현
Select Round(Avg(prod_sale), 2)
  From prod;
  
-- 상품정보에서 상품분류별 판매가격의 평균값 조회
-- 조회 컬럼은 상품분류코드, 상품분류별 판매가격 평균
-- 평균값은 소수점 2번째까지 표현
Select prod_lgu,
       Round(Avg(prod_sale), 2)
  From prod
 Group By prod_lgu
 Order BY prod_lgu Asc;

-- 회원 전체의 마일리지 평균보다 큰 회원에 대한
-- 아이디, 이름 ,마일리지를 조회
-- 정렬은 마일리지가 높은 순으로
Select mem_id as 아이디,
       mem_name as 이름,
       mem_mileage as 마일리지
  From member
 Where mem_mileage > (Select AVG(mem_mileage) From member)
 Order By mem_mileage Desc;

-- Group By
-- Count(column) : 행의 갯수
-- 구매내역 정보에서 회원 아이디별로 구매수량 조회
-- 회원 아이디를 기준으로 내림차순 정렬
Select cart_member as 회원ID,
       Count(cart_qty) as 구매수량
  From cart
 Group By cart_member
 Order By cart_member Desc;
 
-- 회원테이블의 취미종류 수를 Count 집계
Select Count(Distinct(mem_like)) as 취미종류수
  From member;
  
-- 회원테이블의 취미별 COunt 집계
-- 컬럼은 취미, 자료수
Select mem_like as 취미,
       Count(mem_like) as 자료수
  From member
 Group By mem_like;
 
-- 회원테이블의 직업종류 수를 Count 집계
Select Count(Distinct(mem_job)) as 직업종류수
  From member;

-- 회원테이블의 직업별 Count 집계
Select mem_job,
       Count(mem_job)
  From member
 Group By mem_job;
 
-- Max, Min : 최대, 최소
-- 오늘이 2005년 07월 11일이라고 가정라고 장바구니테이블에 발생될 추가주문번호를 검색
-- 컬럼은 현재년월일 기준 가장  큰 주문번호, 다음주문번호
-- 내가 한 방법
Select Max(cart_no) as 가장큰주문번호,
       '20050711' || To_char((substr(Max(cart_no), 9, 13) + 1), '00000') as 다음주문번호
  From cart
 Where substr(cart_no, 1, 8) = '20050711';
-- 정답
Select Max(cart_no) as 가장큰주문번호,
       Max(cart_no) + 1 as 다음주문번호
  From cart
 Where cart_no like '20050711%';
 
-- 구매정보에서 년도별, 상품분류코드별 상품의 갯수를 조회
-- 정렬은 년도를 기준으로 내림차순
-- hint : 년도는 cart_no 앞 4자리, 상품분류코드는 cart_prod 앞 4자리
Select Substr(cart_no, 1, 4) as 년도, 
       Substr(cart_prod, 1, 4) as 상품분류코드,
       Count(*) as 상품갯수
  From cart
 Group By Substr(cart_no, 1, 4), Substr(cart_prod, 1, 4)
 Order By 년도;
 
-- sum : 합계
-- 구매정보에서 년도별로 판매된 상품의 갯수, 평균구매수량을 조회
-- 정렬은 년도를 기준으로 내림차순
Select Substr(cart_no, 1, 4) as 판매년도,
       Sum(cart_qty) as 판매갯수,
       Avg(cart_qty) as  평균구매수량
  From cart
 Group By Substr(cart_no, 1, 4)
 Order By 판매년도 Desc;