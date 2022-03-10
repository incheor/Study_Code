-- 사용자 계정 생성
CREATE USER busan IDENTIFIED BY dbdb;

-- 비밀번호 변경
ALTER USER busan IDENTIFIED BY dbdb;

-- 계정 삭제
Drop USER busan;

-- 권한 부여하기(접속 권한, 관리자 권한)
GRANT CONNECT, RESOURCE, DBA TO busan;

-- 권한 회수하기
REVOKE DBA FROM busan;
