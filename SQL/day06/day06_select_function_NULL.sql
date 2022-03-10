-- NULL 및 빈 값으로 바꾸기
-- commit은 절대 하지마!
-- 거래처 담당자 성이 '김'이면 NULL로 갱신
Update buyer Set buyer_charger = NULL
 Where buyer_charger Like '김%';
 

-- 거래처 담당자 성이 '성'이면 White Space로 갱신
Update buyer Set buyer_charger = ''
 Where buyer_charger Like '성%';

-- NULL 관련 함수
-- is NULL : NULL값인지 비교(True, False)
-- NVL(c, r) : c가 NULL이 아니면 c값 그대로, NULL이면 r반환
-- NVL2(c, r1, r2) :  c가 NULL이 아니면 r1, NULL이면 r반환
Select buyer_name as 거래처,
       NVL(buyer_charger, '없다') as 담당자
  From buyer;
  
-- 회원 마일리지에 100을 더한 수치를 조회
-- 컬럼은 성명, 마일리지, 변경마일리지
Select mem_name as 성명,
       mem_mileage as 마일리지,
       NVL(mem_mileage, 0) + 100 as 변경마일리지
  From member;
  
-- 회원 마일리지가 있으면 '정상회원', NULL이면 '비정상회원'으로 조회
-- 컬럼은 성명, 마일리지, 회원상태
Select mem_name as 성명,
       mem_mileage as 마일리지,
       NVL2(mem_mileage, '정상회원', '비정상회원') as 회원상태
  From member;