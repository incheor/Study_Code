-- 조인

-- 몸풀기(조인 X)
-- 회원정보 중 구매내역이 있는 회원에 대한
-- 회원아이디, 회원이름, 생일(0000-00-00 형태)을 조회
-- 정렬은 생일을 기준으로 오름차순
Select mem_id as 회원아이디,
       mem_name as 회원이름,
       To_char(mem_bir, 'yyyy-mm-dd') as 생일
  From member
 Where mem_id In (
          Select cart_member
            From cart
           Where cart_no Is Not NULL)
 Order By mem_bir Asc;
 
-- 1개의 테이블 조회 : In, Exists
-- In
Select prod_id, prod_name, prod_lgu
  From prod
 Where prod_lgu In (
            Select lprod_gu
              From lprod
             Where lprod_nm = '피혁잡화');

-- Exists     
Select prod_id, prod_name, prod_lgu
  From prod
 Where Exists (
       Select lprod_gu
         From lprod
        Where lprod_gu = prod.prod_lgu
          And lprod_gu = 'P301');
          
-- 조인
-- Cross Join
-- 일반 방식
Select m.mem_id, c.cart_member
  From member m, cart c, prod p;
  
-- 국제표준방식
Select mem_id, cart_member
  From member 
   Cross Join cart 
   Cross Join prod;

-- Inner Join : 일반적인 Join
-- 일반 방식
Select prod.prod_id 상품코드,
       prod.prod_name 상품명,
       lprod.lprod_nm 분류명
  From prod, lprod
 Where prod.prod_lgu = lprod.lprod_gu;
 
-- 국제 표준 방식
Select prod.prod_id 상품코드,
       prod.prod_name 상품명,
       lprod.lprod_nm 분류명
  From prod Inner Join lprod
    On prod.prod_lgu = lprod.lprod_gu;

-- 테이블 3개 이상인 경우
-- 일반 방식
Select P.prod_id,
       P.prod_name,
       L.lprod_nm,
       B.buyer_name
  From prod P, lprod L, buyer B
 Where p.prod_lgu = l.lprod_gu
   And p.prod_buyer = b.buyer_id;

-- 국제 표준 방식
Select P.prod_id,
       P.prod_name,
       L.lprod_nm,
       B.buyer_name
  From prod P
 Inner Join lprod L
    On P.prod_lgu = L.lprod_gu
 Inner Join buyer B
    On P.prod_buyer = B.buyer_id;

-- 회원이 구매한 거래처 정보를 조회
-- 컬럼은 회원아이디, 회원이름, 상품거래처명, 상품분류명
-- 일반 방식
Select Distinct M.mem_id as 회원아이디,
       M.mem_name as 회원이름,
       B.buyer_name as 상품거래처명,
       L.lprod_nm as 상품분류명
  From member M, cart C, prod P, lprod L, buyer B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_lgu = L.lprod_gu
   And L.lprod_gu = B.buyer_lgu
 Order By M.mem_name Asc;
   
-- 국제 표준 방식
Select Distinct M.mem_id as 회원아이디,
       M.mem_name as 회원이름,
       B.buyer_name as 상품거래처명,
       L.lprod_nm as 상품분류명
  From member M
 Inner Join cart C
    On M.mem_id = C.cart_member
 Inner Join prod P
    On C.cart_prod = P.prod_id
 Inner Join lprod L
    On P.prod_lgu = L.lprod_gu
 Inner Join buyer B
    On L.lprod_gu = B.buyer_lgu
 Order By M.mem_name Asc;

Select Distinct M.mem_id as 회원아이디,
       M.mem_name as 회원이름,
       B.buyer_name as 상품거래처명,
       L.lprod_nm as 상품분류명,
       Round(Sum(P.prod_price))
  From member M, cart C, prod P, lprod L, buyer B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_lgu = L.lprod_gu
   And L.lprod_gu = B.buyer_lgu
   And substr(M.mem_name, 1, 1) = '김'
 Group By M.mem_id, M.mem_name, B.buyer_name, L.lprod_nm
Having Sum(P.prod_price) >= 100000
 Order By M.mem_name Asc;
 
-- 거래처가 '삼성전자'인 자료에 대한
-- 상품코드, 상품명, 거래처명을 조회
-- 일반 방식
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       B.buyer_name as buyer_name
  From buyer B, prod P
 Where B.buyer_id = P.prod_buyer
   And B.buyer_name = '삼성전자';
   
-- 국제 표준 방식
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       B.buyer_name as buyer_name
  From buyer B
 Inner Join prod P
    On B.buyer_id = P.prod_buyer
   And B.buyer_name = '삼성전자';
 
-- 상품데이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처주소를 조회
-- 판매가격이 100,000원 이하이고 거래처주소가 '부산'인 경우만 출력
-- 일반 방식
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       P.prod_lgu as prod_lgu,
       B.buyer_name as buyer_name,
       B.buyer_add1 as buyer_add1
  From prod P, buyer B
 Where P.prod_buyer = B.buyer_id
   And P.prod_sale <= 100000
   And substr(B.buyer_add1, 1, 2) = '부산';
   
-- 국제 표준 방식
Select P.prod_id as prod_id,
       P.prod_name as prod_name,
       P.prod_lgu as prod_lgu,
       B.buyer_name as buyer_name,
       B.buyer_add1 as buyer_add1
  From prod P
 Inner Join buyer B
    On P.prod_buyer = B.buyer_id
   And P.prod_sale <= 100000
   And substr(B.buyer_add1, 1, 2) = '부산';
   
-- 상품분류코드가 P101인 것에 대한
-- 상품분류명, 상품아이디, 판매가, 거래처담당자, 회원아이디, 주문수량 조회
-- 정렬은 상품분류명을 기준으로 내림차순, 상품아이디를 기준으로 오름차순
-- 일반 방식
Select L.lprod_nm,
       P.prod_id,
       P.prod_sale,
       B.buyer_charger,
       M.mem_id,
       C.cart_qty
  From prod P, buyer B, lprod L, cart C, member M
 Where P.prod_buyer = B.buyer_id
   And P.prod_lgu = L.lprod_gu
   And P.prod_id = C.cart_prod
   And C.cart_member = M.mem_id
   And L.lprod_gu = 'P101'
 Order BY L.lprod_nm Desc, 
       P.prod_id Asc;
       
-- 국제 표준 방식
Select L.lprod_nm,
       P.prod_id,
       P.prod_sale,
       B.buyer_charger,
       M.mem_id,
       C.cart_qty
  From prod P
 Inner Join buyer B
    ON P.prod_buyer = B.buyer_id
 Inner Join lprod L
    On P.prod_lgu = L.lprod_gu
 Inner Join cart C 
    On P.prod_id = C.cart_prod
 Inner Join member M
    On C.cart_member = M.mem_id
   And P.prod_lgu = 'P101' 
 Order BY L.lprod_nm Desc, 
       P.prod_id Asc;