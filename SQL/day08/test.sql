-- 3조
/*
1. 오철희가 산 물건 중 TV 가 고장나서 교환받으려고 한다
교환받으려면 거래처 전화번호를 이용해야 한다.
구매처와 전화번호를 조회하시오.
*/
Select buyer_name,
       buyer_comtel
  From buyer
 Where buyer_id In (
            Select prod_buyer
              From prod
             Where prod_name Like '%TV%'
               And prod_id In (
                       Select cart_prod
                         From cart
                        Where cart_member In (
                                      Select mem_id
                                        From member
                                       Where mem_name = '오철희')));

/*
2. 대전에 사는 73년이후에 태어난 주부들중 2005년4월에 구매한 물품을 조회하고, 
그상품을 거래하는 각거래처의 계좌 은행명과 계좌번호를 뽑으시오.
(단, 은행명-계좌번호).*/
Select buyer_bank || ' -- ' || buyer_bankno as "은행명-계좌번호"
  From buyer
 Where buyer_id In (
            Select prod_buyer
              From prod
             Where prod_id In (
                       Select cart_prod
                         From cart
                        Where cart_member In (
                                      Select mem_id
                                        From member
                                       Where mem_add1 Like '%대전%'
                                         And Extract(year From mem_bir) >= 73
                                         And mem_job = '주부')));

/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매횟수에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/           
Select mem_id,
       mem_hp,
       NVL((Select sum(cart_qty)
              From cart
             Where cart_member = member.mem_id
             Group By cart_member), 0) as 구매횟수,
       case when NVL((Select sum(cart_qty)
                        From cart
                       Where cart_member = member.mem_id
                    Group By cart_member), 0) >= 5
       then '우수 회원'
       else '일반 회원' end as 회원상태
  From member
 Order By 구매횟수 Asc;

-- Left Outer Join
Select mem_id,
       mem_hp,
       NVL(sum(cart_qty), 0) as 구매횟수,
       case when NVL(sum(cart_qty), 0) >= 5
       then '우수 회원' 
       else '일반 회원' end as 회원상태
  From member
  Left Outer Join cart
    On mem_id = cart_member
 Group By mem_id, mem_hp
 Order By 구매횟수;
  
-- 4조
/*
<태영>
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/
Select buyer_comtel
  From buyer
 Where buyer_id In (
        Select prod_buyer
        From prod
        Where prod_id In (
                Select cart_prod
                From cart
                Where cart_member In (
                        Select mem_id
                        From member
                        Where mem_name = '김성욱')));

/*
<태경>
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을을 '리' 로 치환해서 출력해라 
*/
Select mem_name,
       mem_bir,
       replace(substr(mem_name, 1, 1), '이', '리') || substr(mem_name, 2, 2)
  From member
 Where mem_id In(
          Select cart_member
            From cart
           Where cart_prod In(
                       Select prod_id
                         From prod
                        Where prod_buyer In(
                                     Select buyer_id
                                       From buyer
                                      Where buyer_add1 Not Like '%서울%'
                                        And buyer_bank = '외환은행')));

/*
<덕현>
짝수 달에 구매된 상품들 중 세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가장 높은 값은 10퍼센트 인하된 값으로, 가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)
*/
Select prod_id,
       prod_name,
       prod_price - prod_cost,
       case prod_price - prod_cost
       when (Select max(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%세탁 주의%'
                And prod_id In(
             Select cart_prod
               From cart
              Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 0.9
       when (Select min(prod_price - prod_cost) 
               From prod 
              Where prod_delivery not like '%세탁 주의%'
                And prod_id In(
             Select cart_prod
               From cart
              Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12)))
       then (prod_price - prod_cost) * 1.1
       else prod_price - prod_cost end as 마진
  From prod
 Where prod_delivery not like '%세탁 주의%'
   And prod_id In(
           Select cart_prod
             From cart
            Where substr(cart_no, 5, 2) In (02, 04, 06, 08, 10, 12))
 Group By prod_id, prod_name, prod_price - prod_cost;