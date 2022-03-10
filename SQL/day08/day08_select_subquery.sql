-- 서브쿼리
-- SQL 구문 안에 또 다른 Select 구문이 있는 것을 의미함
-- subquery는 괄호로 묶기
-- 연산자와 사용할 경우 오른쪽에 배치
-- From절에 사용할 경우 view처럼 독립된 테이블처럼 활용돼 inline view라고 부름
-- main query와 sub query의 참조성 여부에 따라 연관 또는 비연관 subquery로 구분함
-- 반환하는 행의 수, 컬럼의 수에 따라 단일행/다중행, 단일컬럼/다중컬럼으로 구분함
-- 아래의 두 개는 결과가 같음
-- 조인
Select prod_id, prod_name, lprod_nm
  From prod
 Inner Join lprod 
    On prod_lgu = lprod_gu;
-- 서브쿼리
Select prod_id, prod_name,(Select lprod_nm From lprod Where prod_lgu = lprod_gu)
  From prod;

-- 오라클에만 있는 서브쿼리 비교연산자 Any, All
-- 비교할 대상 + 비교연산자 + Any/And + 서브쿼리
-- Any : Or의 개념 / All : And의 개념
Select mem_name, mem_job, mem_mileage
  From member
 Where mem_job <> '공무원'
   And mem_mileage > 
   All (Select mem_mileage
          From member
         Where mem_job = '공무원');