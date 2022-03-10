-- 그룹 함수 : Group By 필수, Avg, Conut, Sum, Max
-- 일반 컬럼과 그룹 함수를 같이 사용할 경우에는
-- 꼭 Group By절을 넣어줘야 하며
-- Group By절에 모든 일반 컬럼을 넣어줘야 함
-- 바로 아래의 예시에서 일반 컬럼은 prod_lgu이고
-- 그룹 함수는 Avg(prod_cost)임

-- Avg(coloumn) : 평균을 구함
-- 상품 테이블의 상품분류별 매입가격 평균값
Select prod_lgu as 상품분류,
       Round(Avg(prod_cost), 2) as 평균매입가
  From prod
 Group By prod_lgu;
 
-- Group By절이 필요없는 경우
-- 상품 테이블의 판매가격 평균 값을 조회
-- 컬럼은 상품판매가격평균
Select Round(Avg(prod_sale), 2) as 상품판매가격평균
  From prod;

-- Group By절이 필요한 경우
-- 상품 테이블의 상품분류별 판매가격 평균 조회
Select prod_lgu as 상품분류,
       Round(Avg(prod_sale), 2) as 판매가격평균
  From prod
 Group By prod_lgu;
 
-- Count(column) : 행의 갯수
-- 장바구니 테이블의 회원별 Count 집계
Select cart_member as 회원ID,
 Count(cart_prod) as 자료수
  From cart
 Group By cart_member;
 
-- 구매수량의 전체평균 이상을 구매한 회원들의
-- 아이디와 이름을 조회
Select mem_id,
       mem_name
  From member
  Where mem_id In (
           Select cart_member
             From cart
            Where cart_qty >= (
            Select Avg(cart_qty)
              From cart))
 Order By mem_regno1 Asc;