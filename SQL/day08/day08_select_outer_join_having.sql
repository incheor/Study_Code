-- 조인

-- 몸풀기(조인 X)
-- 상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
-- 상품분류코드가 'P0101', 'P201', 'P301'
-- 매입수량이 15개 이상
-- '서울'에 살고있는 회원 중 생년월일이 1974년인 회원
-- 정렬은 회원아이디를 기준으로 내림차순, 매입수량을 기준으로 내림차순

-- 일반 방식
Select P.prod_lgu,
       P.prod_name,
       p.prod_color,
       B.buy_qty,
       C.cart_qty,
       Y.buyer_name
  From prod P, buyprod B, cart C, member M, buyer Y
 Where P.prod_id = B.buy_prod
   And P.prod_id = C.cart_prod
   And C.cart_member = M.mem_id
   And P.prod_buyer = Y.buyer_id
   And substr(P.prod_lgu, 1, 4) In ('P101', 'P201', 'P301')
   And B.buy_qty >= 15
   And M.mem_add1 Like '%서울%'
   And Extract(year from M.mem_bir) = 1974
 Order By M.mem_id Desc,  B.buy_qty Desc;
 
-- 국제 표준 방식
Select P.prod_lgu,
       P.prod_name,
       p.prod_color,
       B.buy_qty,
       C.cart_qty,
       Y.buyer_name
  From prod P
 Inner Join buyprod B
    On P.prod_id = B.buy_prod
 Inner Join cart C
    On P.prod_id = C.cart_prod
 Inner Join member M
    On C.cart_member = M.mem_id
 Inner Join buyer Y
    On P.prod_buyer = Y.buyer_id
 Where substr(P.prod_lgu, 1, 4) In ('P101', 'P201', 'P301')
   And B.buy_qty >= 15
   And M.mem_add1 Like '%서울%'
   And Extract(year from M.mem_bir) = 1974
 Order By M.mem_id Desc,  B.buy_qty Desc;

-- 2005년도 월별 매입 현황을 조회
-- 컬럼은 매입월, 매입수량, 매입금액(매입수량*상품테이블의 매입가)
Select Extract(month from buy_date),
       sum(buy_qty),
       sum(buy_qty * prod_cost)
  From buyprod
  Inner Join prod
    On buy_prod = prod_id
 Group By Extract(month from buy_date)
 Order By Extract(month from buy_date) Asc;
 
-- 2005년도 월별 판매 현황 조회
-- 판매월, 판매수량, 판매금액
Select substr(cart_no, 5, 2),
       Sum(cart_qty),
       Sum(cart_qty*prod_sale)
  From prod
 Inner Join cart
    On prod_id = cart_prod
 Group By substr(cart_no, 5, 2)
 Order By substr(cart_no, 5, 2) Asc;
 
-- Outer Join
-- Inner Join을 할 때 Join조건식을 만족시키지 못하는 행은 검색에서 빠지게 되는데
-- 이런 누락되는 행들이 검색되도록 하는 Join
-- Join에서 부족한 Table 쪽에 '+' 연산자 기호를 사용(오라클 방식)하고
-- NULL 행을 생성하여 조회할 수 있음
-- 보통 부모를 기준으로 조회함
-- (부모테이블의 컬럼을 그룹, 자식테이블 쪽에 '+' 붙임)
-- 너무 많이 사용할 경우 처리속도가 저하됨
-- 가능하면 국제 표준 방식(Left Outer Join 테이블명 On 관계조건식)으로 하자

-- 전체 분류의 상품자료 수를 조회
-- 1. 전체 분류만 조회 : 9건
Select * 
  From lprod;

-- 2. Inner Join : 6건
Select lprod_gu,
       lprod_nm,
       Count(prod_lgu)
  From lprod, prod
 Where lprod_gu = prod_lgu
 Group By lprod_gu, lprod_nm;
 
-- 3. 오라클 Outer Join : 9건
Select lprod_gu,
       lprod_nm,
       Count(prod_lgu)
  From lprod, prod
 Where lprod_gu = prod_lgu(+)
 Group By lprod_gu, lprod_nm;
 
-- 4. 국제 표준 Outer Join : 9건
Select lprod_gu,
       lprod_nm,
       Count(prod_lgu)
  From lprod
  Left Outer Join prod
    On lprod_gu = prod_lgu
 Group By lprod_gu, lprod_nm;
 
-- 전체 상품의 2005년 01월 입고수량을 조회
-- 상품코드, 상품명, 입고수량
Select prod_id,
       prod_name,
       sum(NVL(buy_qty, 0)) as bq
  From prod
  Left Outer join buyprod
    On prod_id = buy_prod
   And  buy_date Between '05/01/01' And '05/01/31'
 Group By prod_id, prod_name
 Order By prod_id;

-- 서브쿼리로 바꿔보기
Select prod_id,
       prod_name,
       NVL((Select sum(buy_qty)
          From buyprod
         Where buy_prod = prod.prod_id
           And  buy_date Between '05/01/01' And '05/01/31'
         Group By buy_qty), 0) as bq
  From prod
 Group By prod_id, prod_name
 Order By prod_id;

-- 전체 회원의 2005년도 4월의 구매현황 조회
-- 컬럼은 회원ID, 성명, 구매수량의 함
Select mem_id,
       mem_name,
       sum(NVL(cart_qty, 0)) as cq
  From member
  Left Outer Join cart
    On mem_id = cart_member
   And substr(cart_no, 1, 6) = '200504'
 Group By mem_id, mem_name
 Order By mem_id Asc;

-- 서브쿼리로 바꿔보기
Select mem_id,
       mem_name,
       NVL((Select sum(cart_qty)
              From cart
             Where cart_member = member.mem_id
               And substr(cart_no, 1, 6) = '200504'
             Group By cart_member), 0) as cq
  From member
 Group By mem_id, mem_name
 Order By mem_id Asc;

-- Having
-- 상품분류가 컴퓨터제품(P101)인 상품의 2005년도 일자별 판매 조회
-- 판매일, 판매금액(5,000,000원 초과인 경우만), 판매수량
Select substr(cart_no, 1, 8),
       sum(cart_qty*prod_sale),
       sum(cart_qty)
  From prod, cart
 Where prod_id = cart_prod
   And substr(cart_no, 1, 4) = '2005'
   And prod_lgu = 'P101'
 Group By substr(cart_no, 1, 8)
 Having sum(cart_qty*prod_sale) > 5000000
  Order By substr(cart_no, 1, 8);