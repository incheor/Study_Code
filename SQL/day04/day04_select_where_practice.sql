/*
테이블 정보
lprod : 상품분류 정보
prod : 상품정보
buyer : 거래처 정보
member : 회원 정보
cart : 구매(장바구니) 정보
buyprod : 입고 상품 정보
remain : 재고 수불 정보
*/
 
/*
테이블 간의 관계
remain : member, prod
prod : lprod, buyer
buyprod : prod
*/

-- 특정 컬럼 조회
-- 1. 필요한 테이블 찾기
-- 2. 필요한 조건 찾기
-- 3. 필요한 컬럼 찾기
-- 회원 테이블에서 회원 ID와 성명 검색
Select mem_id, mem_name
  From member;

-- 상품 테이블에서 상품 코드와 상품명 검색
Select prod_id, prod_name
  From prod;
  
-- 산술 연산식도 가능
-- 회원 테이블의 마일리지를 12로 나눈 값을 검색
Select mem_mileage,
       mem_mileage / 12 as mem_12
  From member;
  
-- 상품 테이블의 상품코드, 상품명, 판매금액을 검색
-- 판매금액은 판매단가 * 55로 계산
Select prod_id as 상품코드,
       prod_name as 상품명,
       prod_sale * 55 as 판매금액
  From prod;
  
-- 중복된 데이터(행, row) 제거 : distinct
-- 상품 테이블의 거래처 코드를 중복되지 않게 검색
Select Distinct prod_buyer as 거래처
  From prod;
  
-- 정렬 : Order By : 역순으로 정렬할 때는 Desc
-- 컬럼명 대신 Alias, 또는 Select 한 컬럼명의 순서로도 가능
-- Order By 에 여러개를 쓸 경우 첫번째 조건으로 먼저 정렬, 다음 조건으로 정렬
-- 회원 테이블에서 회원 ID, 회원명, 생일, 마일리지 검색
Select mem_id as 회원_ID,
       mem_name as 회원명,
       mem_bir as 생일,
       mem_mileage as 마일리지
  From member
 Order by mem_id, 회원명, 3 Asc;
 
-- Where : 조건
-- 비교 연산자
-- 상품 테이블에서 판매가가 170000원인 상품 조회
Select prod_name as 상품,
       prod_sale as 판매가
  From prod
 Where prod_sale = 170000;

-- 상품 테이블에서 판매가가 170000원이 아닌 상품 조회
Select prod_name as 상품,
       prod_sale as 판매가
  From prod
 Where prod_sale != 170000;

-- 상품 테이블에서 판매가가 170000원을 초과하는 상품 조회
Select prod_name as 상품,
       prod_sale as 판매가
  From prod
 Where prod_sale > 170000;

-- 상품 테이블에서 매입 가격이 200000원 이하인 상품 검색
-- 조회 컬럼은 상품코드, 매입가격, 상품명
-- 상품코드를 기준으로 내림차순
Select prod_id as 상품코드,
       prod_cost as 매입가격,
       prod_name as 상품명
  From prod
 Where prod_cost <= 200000
 Order by prod_id Desc;
 
-- 회원 테이블에서 76년도 1월 1일 이후에 태어난
-- 회원 아이디, 회원 이름, 주민등록번호 앞자리 조회
-- 회원 아이디를 기준으로 오름차순
Select mem_id as 회원아이디,
       mem_name as 회원이름,
       mem_regno1 as 주민등록번호
  From member
 Where mem_regno1 >= 760101
 Order By mem_id;
 
-- 논리 연산자
-- 상품 테이블에서 상품분류가 P201(여성 캐쥬얼)이고 판매가가 170000원인 상품 조회
Select prod_name as 상품명,
       prod_lgu as 상품분류,
       prod_sale as 판매가
  From prod
 Where prod_lgu = 'P201'
   And prod_sale = 170000;
   
-- 상품 테이블에서 상품분류가 P201(여성 캐쥬얼)이 아니고 판매가가 170000원도 아닌 상품 조회
Select prod_name as 상품명,
       prod_lgu as 상품분류,
       prod_sale as 판매가
  From prod
 Where Not(prod_lgu = 'P201'
   And prod_sale = 170000);
   
-- 상품 테이블에서 판매가가 300000원 이상, 500000원 이상인 상품 검색
Select prod_id as 상품코드,
       prod_name as 상품명,
       prod_sale as 판매가
  From prod
 Where prod_sale >= 300000
   And prod_sale <= 500000;
   
-- 상품 테이블에서 판매가가 15만원, 17만원, 33만원인 상품 조회
-- 컬럼은 상품코드, 상품명, 판매가격
-- 정렬은 상품명을 기준으로 오름차순
Select prod_id as 상품코드,
       prod_name as 상품명,
       prod_sale as 판매가격
  From prod
 Where prod_sale = 150000
    Or prod_sale = 170000
    Or prod_sale = 330000;
    
-- 회원 테이블에서 아이디가 c001, f001, w001인 회원 조회
-- 컬럼은 회원 아이디, 회원 이름
-- 정렬은 주민번호 앞자리를 기준으로 내림차순
Select mem_id as 회원아이디,
       mem_name as 회원이름
  From member
 Where mem_id = 'c001'
    Or mem_id = 'f001'
    Or mem_id = 'w001'
 Order By mem_regno1 Desc;