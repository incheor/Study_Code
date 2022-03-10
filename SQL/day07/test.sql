-- 5조
/*
김태호, 이인영, 최다정
[문제]
1. 
'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
*/
SELECT prod_name 이름,
       prod_sale 판매가격,
       prod_sale + NVL(prod_mileage, 0) "판매가격+마일리지"
  FROM prod
 WHERE prod_lgu IN(
            SELECT lprod_gu
              FROM lprod
             WHERE lprod_nm = '여성캐주얼')
   AND prod_name like '%여름%'
   AND prod_id IN (
           SELECT buy_prod
             FROM buyprod
            WHERE buy_qty >= 30
              AND EXTRACT(month FROM buy_date) = 6);

-- 조인
Select P.prod_name as 이름,
       P.prod_sale as 판매가격,
       prod_sale + NVL(prod_mileage, 0) "판매가격+마일리지"
  From prod P, lprod L, buyprod B
 Where P.prod_lgu = L.lprod_gu
   And P.prod_id = B.buy_prod
   And L.lprod_nm = '여성캐주얼'
   ANd P.prod_name Like '%여름%'
   And B.buy_qty >= 30
   AND EXTRACT(month FROM buy_date) = 6;

/*
2. 
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/
Select mem_name as 회원이름,
       mem_mileage as 마일리지,
       case when mem_mileage >= 2500 then '우수회원'
                                     else '일반회원'
                                     end as 회원상태
  From member
 Where mem_id In (
          Select cart_member
            From cart
           Where cart_prod In(
                     Select prod_id
                       From prod
                      Where prod_buyer In(
                                   Select buyer_id
                                     From buyer
                                    Where buyer_id Like '%P20%')
                       And prod_insdate >= '05/02/01'
                       And prod_cost >= 200000));
  
-- 조인
Select Distinct mem_name as 회원이름,
       mem_mileage as 마일리지,
       case when mem_mileage >= 2500 then '우수회원'
                                     else '일반회원'
                                     end as 회원상태
  From member M, cart C, prod P, buyer B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_buyer = B.buyer_id
   And B.buyer_id Like '%P20%'
   And Extract(month from P.prod_insdate) >= 2
   And P.prod_cost >= 200000;

/*
3. 
6월달 이전(5월달까지)에 입고된 상품 중에 
배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 
판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
Alias 이름, 보유 마일리지, 성별
*/
Select mem_name as 이름,
       mem_mileage as 마일리지,
       decode(substr(mem_regno2, 1, 1), 1, '남', '여') as 성별
  From member
 Where mem_id In(
          Select cart_member
            From cart
           Where cart_prod In(
                       Select prod_id
                         From prod
                        Where prod_id In(
                                  Select buy_prod
                                    From buyprod
                                   Where Extract(month from buy_date) < 6)
                          And prod_delivery = '세탁 주의'
                          And prod_color is NULL)
             And cart_qty >= (Select Avg(cart_qty) From cart))
   And substr(mem_name, 1, 1) = '김';
   
-- 조인
Select Distinct mem_name as 이름,
       mem_mileage as 마일리지,
       decode(substr(mem_regno2, 1, 1), 1, '남', '여') as 성별
  From member M, cart C, prod P, buyprod B
 Where M.mem_id = C.cart_member
   And C.cart_prod = P.prod_id
   And P.prod_id = B.buy_prod
   And Extract(month from B.buy_date) < 6
   And P.prod_delivery = '세탁 주의'
   And prod_color is NULL
   And cart_qty >= (Select Avg(cart_qty) From cart)
   And substr(mem_name, 1, 1) = '김';

/*
[문제 만들기]
취급상품코드가 'P1'이고 '인천'에 사는 구매 담당자의 상품을 구매한 
회원의 결혼기념일이 8월달이 아니면서 
평균마일리지(소수두째자리까지) 미만이면서 
구매일에 첫번째로 구매한 회원의 
회원ID, 회원이름, 회원마일리지를 검색하시오.  
*/
SELECT mem_id,
       mem_name,
       round(avg(mem_mileage),2) 
FROM member
WHERE mem_id IN(
         SELECT cart_member  
           FROM cart
          WHERE cart_prod IN(
                      SELECT prod_id
                        FROM prod
                       WHERE prod_buyer IN(
                                    SELECT buyer_id
                                      FROM buyer
                                     Where buyer_add1 like '인천%'
                                       AND buyer_lgu like 'P1%'))
                And substr(cart_no, 9, 13) = '1')
AND mem_memorial = '결혼기념일'
AND extract(month from mem_memorialday) != 8   
AND mem_mileage < (SELECT avg(mem_mileage) FROM member) 
GROUP BY mem_id, mem_name;

/*
[문제 만들기]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 12월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬 
*/
Select mem_id as 아이디,
       mem_name as 이름,
       mem_add1,
       mem_memorial,
       mem_memorialday
  From member
 Where mem_id In(
          Select cart_member
            From cart
           Where cart_prod Not In(
                       Select prod_id
                         From prod
                        Where prod_buyer In(
                                     Select buyer_id
                                       From buyer
                                      Where buyer_add1 LIke '%대전%')))
   And mem_add1 Like '%대전%'
   And substr(mem_regno2, 1, 1) = '2'
   And mem_memorial Like '%결혼기념일%'
   And Extract(month from mem_memorialday) = 2
 Order By mem_name Asc;