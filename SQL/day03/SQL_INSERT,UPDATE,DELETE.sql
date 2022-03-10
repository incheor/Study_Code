-- INSERT, UPDATE, DELETE는 밑에 거 해줘야 입력, 수정, 삭제가 된다
COMMIT; -- 완전 저장
ROLLBACK; -- 취소

-- 데이터 넣기: INSERT INTO + VALUES
-- INSERT INTO와 VALUES의 컬럼과 컬럼 갯수는 같아야 함
-- 한 테이블 안에서 PK는 중복이 돼서는 안 된다
INSERT INTO test
     ( idx, title, descs)
VALUES
     ( 1, '내용증명', NULL);
    
INSERT INTO test
     ( idx, title, descs)
VALUES
     ( 1, '내용증명2', NULL); -- 이건 안 됨, 위의 예시에서 PK인 idx에 1이 들어가 있기 때문
     
INSERT INTO test
     ( idx, title, descs)
VALUES
     ( 2, '내용증명2', '내용내용내용');
     
-- TEST 테이블 오른쪽 클릭, 편집 클릭, 컬럼 추가(REGDATE)
-- 이 컬럼은 NOT NULL이라서 반드시 값을 넣어줘야 INSERT 가능
INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( 3, '내용증명3', '내용내용내용', SYSDATE); -- 현재 날짜 넣을 때는 SYSDATE를 더 많이 쓴다
     
INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( 4, '내용증명4', '내용내용내용', TO_DATE('2021-01-13','yyyy-mm-dd'));
     
-- 시퀀스 사용해 보기(먼저 만들어 놓아야 함), 매크로 같은거
SELECT SEQ_TEST.CURRVAL FROM dual; -- 현재 값을 보여준다
SELECT SEQ_TEST.NEXTVAL FROM dual; -- 시퀀스를 실행시켜 준다(여기서는 현재 값에서 1증가)

--시퀀스 적용해보기
INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( SEQ_TEST.NEXTVAL, '내용증명5', '내용내용내용', SYSDATE);

INSERT INTO test
     ( idx, title, descs, regdate)
VALUES
     ( SEQ_STR.NEXTVAL, '내용증명★', '내용내용내용', SYSDATE);
     
-- 데이터 수정: UPDATE + SET
-- 일부분만 수정하기: UPDATE + SET + WHERE(WHERE 절이 없으면 전부 수정됨, 큰일난다)
-- PK 값은 웬만하면 수정하지 말자
UPDATE test
   SET title = '내용 증명?'
     , descs = '내용이 변경됩니다.'
 WHERE idx = 100;
 
-- 데이터 삭제: DELETE
DELETE FROM test
 WHERE idx = 200;
