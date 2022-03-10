-- Decode : if문 같은 거
-- Decode문 괄호 안에서 가장 왼쪽에 있는 것을 기준으로 비교를 하는데 
-- 오른쪽으로 2개씩 한 세트로
-- 가장 왼쪽에 있는 것과 세트의 왼쪽 거랑 비교하면서 같으면 세트의 오른쪽 것을 반환해주고
-- 아니면 다음 오른쪽 2개 묶음으로 넘어가고 다 아니면 가장 우측에 있는 것을 반환
Select Decode(9, 10, 'A', 9, 'B', 8, 'C', 'D')
  From dual;

Select Decode(substr(prod_lgu, 1, 2), 
             'P1', '컴퓨터/전자 제품', 
             'P2', '의류', 
             'P3', '잡화', '기타')
  From prod;
  
-- 상품 분류 중 앞의 두 글자가 'P1'이면 판매가를 10% 인상하고
-- 'P2'이면 판매가를 15% 인상하고 나머지는 동일 판매가로 조회
-- 컬럼은 상품명, 판매가, 변경판매가
Select prod_name as 상품명,
       prod_sale as 판매가,
       Decode(substr(prod_lgu, 1, 2),
             'P1', prod_sale * 1.1, 
             'P2', prod_sale * 1.15, prod_sale * 1.1) as 변경판매가
  From prod;
  
-- Case A When B Then C When D Then E Else F End : Switch문 같은 거
-- A를 B와 비교해서 같으면 C를 출력하고 아니면 
-- D랑 비교해서 같으면 E를 출력하고 
-- 다 아니면 E를 출력하고 끝냄
-- 회원정보테이블의 주민번호 뒷자리에서 성별을 조회
-- 컬럼은 회원명, 주민번호(13자리), 성별
Select mem_name as 회원명,
       mem_regno1 || '-' || mem_regno2 as 주민번호,
       Case substr(mem_regno2, 1, 1) When '1' Then '남'
                                     When '2' Then '여' End as 성별
  From member;