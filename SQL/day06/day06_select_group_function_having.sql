-- Having
-- 상품테이블에서 상품분류별 판매가 전체의
-- 평균, 합계, 최고가, 최저가, 자료수를 조회
Select prod_lgu as 상품분류,
       Round(Avg(prod_sale), 2) as 평균가격,
       Sum(prod_sale) as 합계,
       Max(prod_sale) as 최고가,
       Min(prod_sale) as 최저가,
       Count(prod_sale) as 자료수
  From prod
 Group By prod_lgu
 Order By prod_lgu Asc;
  
-- 상품테이블에서 상품분류별 판매가 전체의
-- 평균, 합계, 최고가, 최저가, 자료수를 조회
-- 조건 : 자료수가 20개 이상인 것
Select prod_lgu as 상품분류,
       Round(Avg(prod_sale), 2) as 평균가격,
       Sum(prod_sale) as 합계,
       Max(prod_sale) as 최고가,
       Min(prod_sale) as 최저가,
       Count(prod_sale) as 자료수
  From prod
 Group By prod_lgu
 Having Count(prod_sale) >= 20
 Order By prod_lgu Asc;
 
-- 회원테이블에서 지역(주소1의 2자리), 생년월일별
-- 마일리지 평균, 합계, 최고, 최저, 자료수 조회
-- 컬럼은 지역, 년, 평균, 합계, 최고, 최저, 자료수
Select Substr(mem_add1, 1, 2) as 지역,
       Substr(mem_bir, 1, 2) as 년,
       Avg(mem_mileage) as 평균,
       Sum(mem_mileage) as 합계,
       Max(mem_mileage) as 최고,
       Min(mem_mileage) as 최저,
       Count(mem_mileage) as 수
  From member
 Group By Substr(mem_add1, 1, 2), Substr(mem_bir, 1, 2)
 Order By Substr(mem_add1, 1, 2), Substr(mem_bir, 1, 2) Asc;