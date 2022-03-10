-- 대전 지역에 거주하고 생일이 2월이고 구매일자가 4월 ~ 6월 사이인 회원 중 
-- 구매수량이 전체회원의 평균 구매수량보다 높은 회원을 조회하고
-- "(mem_name) 회원님의 (Extract(month form mem_bir)) 월 생일을 진심으로 축하합니다. 
-- 2마트 (mem_add 중 2글자) 점을 이용해 주셔서 감사합니다.
-- 이번 2월 동안에는 VVIP회원으로 마일리지를 3배로 사용하실 수 있습니다.
-- 앞으로도 많은 이용 바랍니다." 출력
-- 컬럼은 회원명, 성별, 주소, 이메일 주소, 생일 축하 문구
Select mem_name as 이름,
       Decode(substr(mem_regno2, 1, 1), '1', '남', '여') as 성별,
       mem_mail as 이메일,
       mem_name || ' 회원님의 ' || Extract(month from mem_bir) || '월 생일을 진심으로 축하합니다. ' ||
       '2마트 ' || substr(mem_add1, 1, 2) || '점을 이용해 주셔서 감사합니다.' ||
       '이번 2월 동안에는 VIP회원으로 마일리지를 2배로 사용하실 수 있습니다.' as 생일축하멘트
  From member
 Where substr(mem_add1, 1, 2) Like '대전%'
   And Extract(month from mem_bir) = 2
   And mem_id In(
          Select cart_member
            From cart
           Where cart_qty >= (Select Avg(cart_qty) From cart)
             And to_number(substr(cart_no, 5, 2)) Between 4 And 6);
-- 2월생 회원이 없기 때문에 아무것도 출력되지 않음
              
-- [문제]
-- 주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
-- 뒤 두글자가 01이면 판매가를 10%인하하고
-- 02면 판매가를 5%인상 나머지는 동일 판매가로 도출
-- (변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오. (원화표기 및 천단위구분))
-- (alias 상품분류, 판매가, 변경판매가)
Select prod_name,
       prod_lgu,
       TO_CHAR(prod_sale,'L9,999,999'),
       DECODE(SUBSTR(prod_id,9,10),
       '01', prod_sale - (prod_sale * 10/100),
       '02', prod_sale + (prod_sale * 5/100)) as "변경판매가"                       
  From prod
 Where prod_id IN(
           SELECT cart_prod 
             From cart
            WHERE cart_member IN(
                          SELECT mem_id
                            FROM member    
                           Where EXTRACT(MONTH From mem_bir) = '1' ))                                                          
   And prod_sale Between 500000 AND 1000000;


/* [문제]
신용환님의 2005년 월별로 판매된 총 상품 갯수,
평균판매수량을 조회
2005년 월이 큰 순으로 내림차순 정렬
단 전체 기간 평균 판매 갯수 보다 미만인 수만 조회
Alias 판매일자, 월별 수량 합계 , 월별 합계 
*/

SELECT 
          SUBSTR(cart_no, 1, 6) AS YYYYMM,
          SUM(cart_qty) AS sum_qty,
          AVG(cart_qty) AS avg_qty
FROM cart
  WHERE cart_member = (SELECT mem_id
                                   FROM member
                                    WHERE mem_name = '신용환')
  GROUP BY SUBSTR(cart_no, 1, 6)
  HAVING AVG(cart_qty) < (SELECT AVG(cart_qty) 
                                        FROM cart)
ORDER BY YYYYMM DESC;