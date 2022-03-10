-- 상품 테이블 중 판매가가 150000원, 170000원, 330000원인 상품 조회
Select prod_id, prod_name, prod_sale
  From prod
 Where prod_sale in (150000, 170000, 330000);
 
-- 상품 테이블 중 판매가가 150000원, 170000원, 330000원이 아닌 상품 조회
Select prod_id, prod_name, prod_sale
  From prod
 Where prod_sale Not In (150000, 170000, 330000);

-- In 안에 Select문 : 서브 쿼리임 - 단일 컬럼의 다중 행 형태
-- 상품분류 테이블에서 현재 상품 테이블에 존재하는 분류만 검색(분류코드, 분류명)
Select lprod_gu as 분류코드,
       lprod_nm as 분류명
  From lprod
 Where lprod_gu In (
            Select prod_lgu 
              From prod);
 
-- 상품분류 테이블에서 현재 상품 테이블에 존재하지 않는 분류만 검색
Select lprod_gu as 분류코드,
       lprod_nm as 분류명
  From lprod
 Where lprod_gu Not In (
                Select prod_lgu 
                  From prod);
 
-- 한 번도 구매한 적이 없는 회원 아이디, 이름 조회
Select mem_id as 아이디,
       mem_name as 이름
  From member
 Where mem_id Not In (
              Select cart_member 
                From cart);
                
-- 한 번도 판매된 적이 없는 상품의 이름 조회
Select prod_name as 상품명
  From prod
 Where prod_id Not In (
               Select cart_prod
                 From cart);
                 
-- 회원 중 김은대 회원이 지금까지 구매했던 모든 상품명 조회
Select prod_name as 상품명
  From prod
 Where prod_id In (
           Select cart_prod
             From cart
            Where cart_member In (
                          Select mem_id
                            From member
                           Where mem_name = '김은대'));

-- 상품 중 판매가격이 10만원 이상, 30만원 이하니 상품 조회
-- 조회할 컬럼은 상품명, 판매가격
-- 정렬은 판매가격을 기준으로 내림차순
Select prod_name as 상품명,
       prod_sale as 판매가
  From prod
 Where prod_sale >= 100000
   And prod_sale <= 300000
 Order By prod_sale Desc;
 
-- Between A And B : A 이상 B 이하에서만 가능(초과, 미만에서는 못 씀)
-- 회원 중 생일이 1975-01-01에서 1976-12-31 사이에 태어난 회원을 조회
Select mem_id as 회원ID,
       mem_name as 회원이름,
       mem_bir as 회원생일
  From member
 Where mem_bir Between '1975/01/01' And '1976/12/31';
 
-- 거래처 담당자 강남구 씨가 담당하는 상품을 구매한 회원을 조회
-- 컬럼은 회원 아이디, 회원 이름
-- prod 테이블에서 buyer 테이블로 바로 연결하면 0건 나옴
-- prod 테이블에서 lprod 테이블을 거쳐 buyer 테이블로 연결하면 11건 나옴
-- 만약 이 DB의 데이터가 정확하다면 같이 나와야 함, 하지만 이 DB는 다르게 나왔기 때문에 정확하지 않음
Select mem_id as 회원아이디,
       mem_name as 회원이름
  From member
 Where mem_id In (
          Select cart_member
            From cart
           Where cart_prod In (
                       Select prod_id
                         From prod
                        Where prod_lgu In (
                                     Select lprod_gu
                                       From lprod
                                      Where lprod_gu In (
                                                 Select buyer_lgu
                                                   From buyer
                                                  Where buyer_charger = '강남구'))));
                                                  
-- 상품 중 매입가가 300000 ~ 1500000이고
-- 판매가가 800000 ~ 2000000인 상품을 조회
-- 컬럼은 상품명, 매입가, 판매가
Select prod_name as 상품명,
       prod_cost as 매입가,
       prod_sale as 판매가
  From prod
 Where prod_cost Between 300000 And 1500000
   And prod_sale Between 800000 And 2000000;
   
-- 회원 중 생일이 1975년도 생이 아닌 회원을 조회
-- 컬럼은 회원 ID, 회원 이름, 생일
Select mem_id as 회원ID,
       mem_name as 회원이름,
       mem_bir as 생일
  From member
 Where mem_bir Not Between '1975/01/01' And '1975/12/31';
 
-- Like 연산자
-- 회원 테이블에서 김씨 성의 회원을 조회
-- 컬럼은 회원 ID, 회원 이름
Select mem_id as 회원ID,
       mem_name as 회원이름
  From member
 Where mem_name Like '김%';
 
-- 회원테이블의 주민번호 앞자리를 검색해
-- 1975년생을 제외한 회원을 조회
-- 컬럼은 회원ID, 회원이름, 주민번호
Select mem_id as 회원ID,
       mem_name as 회원이름,
       mem_regno1 as 주민번호
  From member
 Where mem_regno1 Not Like '75%';