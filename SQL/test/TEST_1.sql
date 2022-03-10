-- 회원 테이블에서 이메일, 모바일, 이름, 주소, 레벨 열의 순서로 출력하고, 
-- 이름을 내림차순으로, 이메일은 소문자로 출력하세요.
SELECT LOWER(mem.email)
     , mem.mobile
     , mem.names
     , mem.addr
     , mem.levels 
  FROM membertbl mem
 ORDER BY mem.names DESC;
